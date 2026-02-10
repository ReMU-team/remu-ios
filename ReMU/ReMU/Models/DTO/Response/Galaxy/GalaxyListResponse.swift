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

struct GalaxySummary: Codable, Identifiable {
    let id: Int          // SwiftUI용 ID
    let galaxyId: Int
    let name: String
    let emojiResourceName: String
    
    enum CodingKeys: String, CodingKey {
        case galaxyId
        case name
        case emojiResourceName
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        galaxyId = try container.decode(Int.self, forKey: .galaxyId)
        name = try container.decode(String.self, forKey: .name)
        emojiResourceName = try container.decode(String.self, forKey: .emojiResourceName)
        id = galaxyId
    }
}

typealias GalaxyListResponse = BaseResponse<GalaxyListResult>
