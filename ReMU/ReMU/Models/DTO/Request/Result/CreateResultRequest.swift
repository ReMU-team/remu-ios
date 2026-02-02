//
//  CreateResultRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct createResultRequest: Codable {
    let emojiId: String
    let reflection: String
    let review: [String]
}

struct reviewItem: Codable {
    let resolutionId: Int
    let reviewContent: String
    let isResolutionFulfilled: Bool
}
