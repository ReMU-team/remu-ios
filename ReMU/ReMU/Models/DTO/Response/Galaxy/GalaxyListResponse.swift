//
//  GalaxyListResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct GalaxyListResult: Codable {
    let totalCount: Int
    let galaxies: [GalaxySummary]
    let currentPage: Int
    let hasNext: Bool
}

struct GalaxySummary: Codable {
    let galaxyId: Int
    let name: String
    let emojiResourceName: String
}

typealias GalaxyListResponse = BaseResponse<GalaxyListResult>
