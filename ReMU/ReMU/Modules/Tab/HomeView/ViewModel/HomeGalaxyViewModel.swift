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

@Observable
class GalaxyDetailViewModel {
    // Galaxy Model
    // var galaxyDetail : Galaxy?
    var galaxyDetailResponse: GalaxyDetailResponse?
    var starListResponse: StarListResponse?
    
    // Pagination
    var dDay: Int = 0
    var month: Int
    var day: Int
    
    
    private(set) var isLoading: Bool = false
    
    // MARK: - Properties
    private let galaxyDetailProvider: MoyaProvider<GalaxyTargetType>
    private let starLIstProvider: MoyaProvider<StarTargetType>
    private let container: DIContainer
    
    // MARK: - AccessToken Load KeychainService
    private let keychain: UserSessionKeychainService
    
    // 의존성 주입
    init(container: DIContainer) {
        self.container = container
        self.galaxyDetailProvider = container.apiProviderStore.galaxy()
        self.starLIstProvider = container.apiProviderStore.star()
        self.keychain = container.userSessionKeychain
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: Date())
        self.month = components.month ?? 0
        self.day = components.day ?? 0
    }
    
    
    
    // MARK: - Func
    @MainActor
    func fetchGalaxyDetailData(galaxyId: Int) async {
        // 1. 키체인에서 세션 로드 및 토큰 추출
        guard let session = keychain.loadSession(for: .userSession),
              let accessToken = session.accessToken else {
            print("토큰이 없습니다.")
            return
        }
        
        self.isLoading = true
        
        do {
            let response = try await galaxyDetailProvider.requestAsync(.fetchGalaxyDetail(accessToken: accessToken, galaxyId: galaxyId)
            )
            let dto = try JSONDecoder().decode(GalaxyDetailResponse.self, from: response.data)
            self.galaxyDetailResponse = dto
                
        } catch {
            print("네트워크 에러: \(error)")
        }
        self.isLoading = false
    }
    
    @MainActor
    func fetchStarListData(galaxyId: Int) async {
        guard let session = keychain.loadSession(for: .userSession),
              let accessToken = session.accessToken else {
            print("토큰이 없습니다.")
            return
        }
        do{
            let response = try await starLIstProvider.requestAsync(.fetchStarsList(accessToken: accessToken, galaxyId: galaxyId)
            )
            let dto = try JSONDecoder().decode(StarListResponse.self, from: response.data)
            self.starListResponse = dto
            
        } catch{
            print("네트워크 에러: \(error)")
        }
        
    }
    
}


class HomeViewModel: ObservableObject {
    // 1. View에서 관찰할 데이터들
    @Published var galaxyData: Galaxy?
    @Published var partitionedStars: [[Star]] = []
    @Published var scale: CGFloat = 1
    
    init() {
        // 초기 데이터 로드 (추후 API 연동 시 이 함수에서 호출)
        fetchGalaxyData()
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

