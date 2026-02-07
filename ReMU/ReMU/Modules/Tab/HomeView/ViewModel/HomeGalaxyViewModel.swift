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

@Observable
class GalaxyHomeViewModel {
    
    // MARK: - Properties
    private let GalaxyDetailProvider: MoyaProvider<GalaxyTargetType>
    // 의존성 주입
    init(container: DIContainer) {
        self.GalaxyDetailProvider = container.apiProviderStore.galaxy()
    }
    
    // MARK: - Func
    @MainActor
    func fetchGalaxyDetailData(galaxyId: Int) async {
        do {
            let response = try await GalaxyDetailProvider.requestAsync(.fetchGalaxyDetail(galaxyId: galaxyId))
            let dto = try JSONDecoder().decode(GalaxyDetailResponse.self, from: response.data)
        } catch {
            
        }
    }
    
    
}


class HomeViewModel: ObservableObject {
    // 1. View에서 관찰할 데이터들
    @Published var galaxyData: Galaxy?
    @Published var partitionedStars: [[Star]] = []
    @Published var scale: CGFloat = 1
    
    @Published var selectedRecordCard: RecordCardModel?
    @Published var isShowingRecordCard = false
    
    private let starProvider: MoyaProvider<StarTargetType>
    private let userSession: UserSessionKeychainService
    
    init(container: DIContainer = .preview) {
        // 초기 데이터 로드 (추후 API 연동 시 이 함수에서 호출)
        self.starProvider = container.apiProviderStore.star()
        self.userSession = container.userSessionKeychain
        fetchGalaxyData()
    }
    
    // 별 클릭 진입 함수
    func onSelectStar(starId: Int) {
        _Concurrency.Task {
            await fetchStarDetail(starId: starId)
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

    func fetchGalaxyData() {
        // 목데이터 로드 및 궤도 분할 계산 실행
        let data = Galaxy.mock
        //self.galaxyData = nil
        self.galaxyData = data
        self.partitionedStars = partitionStars(data.stars)
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

