//
//  StarListResponse.swift
//  ReMU
//
//  Created by 김진서 on 2/7/26.
//

import Foundation

struct StarListResponse: Decodable {
    let starId: Int
    let title: String
    let recordDate: String
    let cardColor: String
    let dday: Int
}

typealias StarListAPIResponse = BaseResponse<[StarListResponse]>
