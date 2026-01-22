//
//  Galaxy.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Galaxy: Identifiable {
    let id: Int

    // MARK: - 생성 시 결정 (필수)
    let name: String              // 은하 이름
    let placeName: String         // 장소명
    let startDate: Date?
    let endDate: Date?
    let imageName: String         // 은하 이미지 (asset name)

    // MARK: - 상태
    var status: GalaxyStatus
}

// 은하 상태
enum GalaxyStatus {
    case ready        // 여행 전
    case ongoing      // 여행 중
    case completed    // 여행 종료
}
