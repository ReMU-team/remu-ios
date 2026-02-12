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
    
    @Published var pledgeCard: PledgeCardModel?
    @Published var selectedRecordCard: RecordCardModel?
    @Published var isShowingRecordCard = false
    @Published var isLoading: Bool = false
    
    private let pledgeProvider: MoyaProvider<PledgeTargetType>
    private let starProvider: MoyaProvider<StarTargetType>
    private let userSession: UserSessionKeychainService
    private let container: DIContainer
    
    init(container: DIContainer = .preview) {
        self.container = container
        self.starProvider = container.apiProviderStore.star()
        self.userSession = container.userSessionKeychain
        self.pledgeProvider = container.apiProviderStore.pledge()
    }

    // MARK: - 홈 진입용 메인 로딩 함수
    @MainActor
    func loadHome(galaxyId: Int) async {
        await fetchGalaxyDetail(galaxyId: galaxyId)
    }
    @MainActor
    func loadHomeIfNeeded(galaxyId: Int) async {
        if galaxyData?.serverId == galaxyId {
            return
        }

        await fetchGalaxyDetail(galaxyId: galaxyId)
    }

    
    //은하 선택이 없는 상태로 홈을 리셋하는 함수
    @MainActor
    func clear() {
        galaxyData = nil
        partitionedStars = []
        selectedRecordCard = nil
        isShowingRecordCard = false
        pledgeCard = nil
    }

    
    // 별 클릭 진입 함수
    func onSelectStar(starId: Int) {
        _Concurrency.Task {
            await fetchStarDetail(starId: starId)
        }
    }
    
    // MARK: - 다짐 조회
    @MainActor
    private func fetchPledge(for galaxy: Galaxy) async {
        do {
            let response = try await pledgeProvider.requestAsync(
                .checkPledge(galaxyId: galaxy.serverId)
            )

            let dto = try JSONDecoder().decode(CheckPledgeResponse.self, from: response.data)

            guard let result = dto.result else { return }

            self.pledgeCard = PledgeCardModel(
                galaxy: galaxy,
                emojiImageName: result.emojiId,
                pledges: result.resolutionList.map {
                    Pledge(
                        resolutionId: $0.resolutionId,
                        content: $0.content
                    )
                }

            )

        } catch {
            print("❌ 다짐 조회 실패:", error)
        }
    }


    // MARK: - 은하 상세 조회 API
    @MainActor
    private func fetchGalaxyDetail(galaxyId: Int) async -> Bool {

        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            return false
        }

        let galaxyProvider = container.apiProviderStore.galaxy()

        do {
            let response = try await galaxyProvider.requestAsync(
                .fetchGalaxyDetail(accessToken: accessToken, galaxyId: galaxyId)
            )

            let dto = try JSONDecoder().decode(GalaxyDetailResponse.self, from: response.data)

            guard let result = dto.result,
                  let startDate = result.startDate.toDateFromServer,
                  let endDate = result.endDate.toDateFromServer
            else {
                return false
            }

            let newGalaxy = Galaxy(
                serverId: result.galaxyId,
                title: result.name,
                destination: result.placeName,
                startDate: startDate,
                endDate: endDate,
                totalDay: Calendar.current
                    .dateComponents([.day], from: startDate, to: endDate).day! + 1,
                galaxyIcon: result.emojiResourceName,
                dDay: result.dDay,
                stars: []
            )

            if galaxyData?.serverId != newGalaxy.serverId {
                galaxyData = newGalaxy
            } else {
                if galaxyData?.title != newGalaxy.title ||
                    galaxyData?.destination != newGalaxy.destination ||
                    galaxyData?.galaxyIcon != newGalaxy.galaxyIcon ||
                    galaxyData?.dDay != newGalaxy.dDay {
                    galaxyData = newGalaxy
                }
            }

            await fetchStarsList(galaxyId: result.galaxyId)
            
            await fetchPledge(for: newGalaxy)
            
            return true

        } catch {
            return false
        }
    }


    // MARK: - 은하 리스트 조회 API
    @MainActor
    func fetchGalaxyList() async -> [GalaxySummary] {

        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            return []
        }

        let galaxyProvider = container.apiProviderStore.galaxy()

        do {
            let response = try await galaxyProvider.requestAsync(
                .fetchGalaxyList(accessToken: accessToken, page: 0, size: 10)
            )

            let dto = try JSONDecoder().decode(GalaxyListResponse.self, from: response.data)

            return dto.result?.galaxies ?? []

        } catch {
            print("❌ 은하 리스트 조회 실패:", error)
            return []
        }
    }


    // MARK: - 별 상세 조회 API
    @MainActor
    private func fetchStarDetail(starId: Int) async {
        print("🔥 fetchStarDetail called")
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
            withAnimation {
                self.isShowingRecordCard = true
            }

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

    // MARK: - 은하 로컬 업데이트
    @MainActor
    func updateGalaxyLocally(
        name: String,
        destination: String,
        startDate: Date,
        endDate: Date,
        icon: String
    ) {
        guard var current = galaxyData else { return }

        current = Galaxy(
            serverId: current.serverId,
            title: name,
            destination: destination,
            startDate: startDate,
            endDate: endDate,
            totalDay: Calendar.current
                .dateComponents([.day], from: startDate, to: endDate).day! + 1,
            galaxyIcon: icon,
            dDay: current.dDay,
            stars: current.stars
        )

        galaxyData = current
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

