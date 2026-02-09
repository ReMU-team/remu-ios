//
//  StarListResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/7/26.
//

import Foundation

struct StarListItem: Codable {
    let starId: Int
    let title: String
    let recordDate: String // "2024-05-21"
    let dDay: Int
    let cardColor: String // "PURPLE", "BLUE" 등
}

// 전체 응답 구조체 (기존에 정의하신 BaseResponse를 사용한다고 가정)
typealias StarListResponse = BaseResponse<[StarListItem]>
