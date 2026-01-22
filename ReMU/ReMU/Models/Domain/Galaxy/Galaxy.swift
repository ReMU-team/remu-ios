//
//  Galaxy.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Galaxy: Identifiable {
    let id: UUID

    // MARK: - 생성 시 결정 (필수)
    let name: String              // 은하 이름
    let destination: String         // 장소명
    let startDate: Date?
    let endDate: Date?
    let imageName: String         // 은하 이미지 (asset name)
}
