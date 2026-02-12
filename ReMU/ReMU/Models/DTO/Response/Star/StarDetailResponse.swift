//
//  StarDetailResponse.swift
//  ReMU
//
//  Created by 김진서 on 2/7/26.
//

import Foundation

/// 기록 카드 상세 조회
struct StarDetailResponse: Decodable {
    let starId: Int
    let title: String
    let content: String
    let recordDate: String   // yyyy-MM-dd
    let dday: Int
    let imageUrl: String?
    let cardColor: String
    let emojis: [String]
}

enum CodingKeys: String, CodingKey {
    case starId
    case title
    case content
    case recordDate
    case imageUrl
    case cardColor
    case emojis
    case dday = "dday"
}

typealias StarDetailAPIResponse = BaseResponse<StarDetailResponse>
