//
//  PatchPledgeRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

struct PatchPledgeRequest: Codable {
    let emojiId: String?
    let resolutions: [ResolutionItem] // 배열 형태로 선언
}

struct ResolutionItem: Codable {
    let resolutionId: Int?
    let content: String?
}
