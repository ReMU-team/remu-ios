//
//  GalaxyViewModel.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI
import Combine
import Moya
import _Concurrency

class HomeViewModel: ObservableObject {
    // 1. View에서 관찰할 데이터들
    @Published var galaxyData: Galaxy?
    @Published var partitionedStars: [[Star]] = []
    @Published var scale: CGFloat = 1
    
    @Published var selectedRecordCard: RecordCardModel?
    @Published var isShowingRecordCard = false
    @Published var isLoading: Bool = false
    
    private let starProvider: MoyaProvider<StarTargetType>
    private let userSession: UserSessionKeychainService
    private let container: DIContainer
    
    init(container: DIContainer = .preview) {
        self.container = container
        self.starProvider = container.apiProviderStore.star()
        self.userSession = container.userSessionKeychain
    }

    // MARK: - 홈 진입용 메인 로딩 함수
    @MainActor
    func loadHome(galaxyId: Int) async -> Bool {
        isLoading = true
        defer { isLoading = false }
        
        let success = await fetchGalaxyDetail(galaxyId: galaxyId)
        if !success {
            clear()
        }
        
        return success
    }
    
    //은하 선택이 없는 상태로 홈을 리셋하는 함수
    @MainActor
    func clear() {
        galaxyData = nil
        partitionedStars = []
        selectedRecordCard = nil
        isShowingRecordCard = false
    }

    
    // 별 클릭 진입 함수
    func onSelectStar(starId: Int) {
        _Concurrency.Task {
            await fetchStarDetail(starId: starId)
        }
    }
    
    // MARK: - 은하 상세 조회 API
    @MainActor
    private func fetchGalaxyDetail(galaxyId: Int) async -> Bool {
        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            print("❌ accessToken 없음")
            galaxyData = nil
            return false
        }

        let galaxyProvider = container.apiProviderStore.galaxy()

        do {
            let response = try await galaxyProvider.requestAsync(
                .fetchGalaxyDetail(accessToken: accessToken, galaxyId: galaxyId)
            )

            let dto = try JSONDecoder().decode(GalaxyDetailResponse.self, from: response.data)

            guard let result = dto.result else {
                galaxyData = nil
                return false
            }

            guard
                let startDate = result.startDate.toDateFromServer,
                let endDate = result.endDate.toDateFromServer
            else {
                print("❌ 날짜 파싱 실패")
                galaxyData = nil
                return false
            }

            self.galaxyData = Galaxy(
                serverId: result.galaxyId,
                title: result.name,
                destination: result.placeName,
                startDate: startDate,
                endDate: endDate,
                totalDay: result.dDay,
                galaxyIcon: result.emojiResourceName,
                stars: []
            )
            
            NotificationScheduler.shared.evaluateTodayNotifications(galaxy: self.galaxyData!)

            // 별 리스트 이어서 조회
            await fetchStarsList(galaxyId: result.galaxyId)
            return true
        } catch {
            print("❌ 은하 상세 조회 실패:", error)
            galaxyData = nil
            return false
        }
    }

    // MARK: - 은하 리스트 조회 API
    @MainActor
    func fetchGalaxyList() async {
        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            print("❌ accessToken 없음")
            galaxyData = nil
            return
        }

        let galaxyProvider = container.apiProviderStore.galaxy()

        do {
            let response = try await galaxyProvider.requestAsync(
                .fetchGalaxyList(accessToken: accessToken, page: 0, size: 10)
            )

            let dto = try JSONDecoder().decode(GalaxyListResponse.self, from: response.data)

            guard let first = dto.result?.galaxies.first else {
                galaxyData = nil   // 은하 없음
                return
            }

            await fetchGalaxyDetail(galaxyId: first.galaxyId)

        } catch {
            print("❌ 은하 리스트 조회 실패:", error)
            galaxyData = nil
        }
    }


    // MARK: - 별 상세 조회 API
    @MainActor
    private func fetchStarDetail(starId: Int) async {
        guard
                let session = userSession.loadSession(for: .userSession),
                let accessToken = session.accessToken
            else {
                print("❌ accessToken 없음")
                return
            }

        // API 요청
        do {
            let response = try await starProvider.requestAsync(
                .fetchStarDetail(accessToken: accessToken, starId: starId)
            )

            // 디코딩
            let apiResponse = try JSONDecoder().decode(
                StarDetailAPIResponse.self,
                from: response.data
            )

            // result 언래핑
            guard let result = apiResponse.result else {
                        print("❌ StarDetail result 없음")
                        return
                    }

            // UI 모델 변환
            self.selectedRecordCard = RecordCardModel.from(
                dto: result,
                galaxy: galaxyData
            )
            self.isShowingRecordCard = true

        } catch {
            print("❌ 별 상세 조회 실패:", error)
        }
    }
    
    // MARK: - 별 리스트 조회 API
    @MainActor
    func fetchStarsList(galaxyId: Int) async {
        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            print("❌ accessToken 없음")
            return
        }

        do {
            let response = try await starProvider.requestAsync(
                .fetchStarsList(accessToken: accessToken, galaxyId: galaxyId)
            )

            let apiResponse = try JSONDecoder().decode(
                StarListResponse.self,
                from: response.data
            )

            guard let result = apiResponse.result else {
                print("❌ StarList result 없음")
                return
            }

            let stars: [Star] = result.map { dto in
                Star(
                    serverId: dto.starId,
                    name: dto.title,
                    dayOffset: dto.dDay,
                    starIcon: dto.cardColor
                )
            }

            self.partitionedStars = partitionStars(stars)

        } catch {
            print("❌ 별 리스트 조회 실패:", error)
        }
    }



    
    // 2. 궤도 배치 알고리즘: 별의 개수에 따라 2, 3, 4... 개씩 묶음
    private func partitionStars(_ stars: [Star]) -> [[Star]] {
        var partitioned: [[Star]] = []
        var remainingStars = stars
        var currentCapacity = 2 // 첫 번째 궤도는 최대 2개
        
        while !remainingStars.isEmpty {
            let count = min(remainingStars.count, currentCapacity)
            partitioned.append(Array(remainingStars.prefix(count)))
            remainingStars.removeFirst(count)
            currentCapacity += 1 // 다음 궤도는 수용량 +1 증가
        }
        return partitioned
    }
    
    // 3. 줌 제스처 처리
    func updateScale(magnitude: CGFloat) {
        self.scale = magnitude
    }
}

