//
//  GalaxyStarSummaryResponse.swift
//  ReMU
//
//  Created by 김진서 on 2/7/26.
//

import Foundation

/// 홈뷰 속 은하의 별 요약
struct GalaxyStarSummaryResponse: Decodable {
    let starId: Int
    let title: String
    let recordDate: String
    let cardColor: String
    let dday: Int
}

typealias GalaxyStarSummaryListResponse
    = BaseResponse<[GalaxyStarSummaryResponse]>

