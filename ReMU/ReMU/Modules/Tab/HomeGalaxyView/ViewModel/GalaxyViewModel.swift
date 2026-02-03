//
//  GalaxyViewModel.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    // 1. View에서 관찰할 데이터들
    @Published var galaxyData: GalaxyData?
    @Published var partitionedStars: [[StarData]] = []
    @Published var scale: CGFloat = 1
    
    init() {
        // 초기 데이터 로드 (추후 API 연동 시 이 함수에서 호출)
        fetchGalaxyData()
    }
    
    func fetchGalaxyData() {
        // 목데이터 로드 및 궤도 분할 계산 실행
        let data = GalaxyData.mock
        //self.galaxyData = nil
        self.galaxyData = data
        self.partitionedStars = partitionStars(data.stars)
    }
    
    // 2. 궤도 배치 알고리즘: 별의 개수에 따라 2, 3, 4... 개씩 묶음
    private func partitionStars(_ stars: [StarData]) -> [[StarData]] {
        var partitioned: [[StarData]] = []
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

