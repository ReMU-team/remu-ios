//
//  CheckPledgeResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct CheckPledgeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CheckPledgeResult
}

struct CheckPledgeResult: Codable {
    let emojiId: String
    let resolutionList: [ResolutionItems]
    let listSize: Int
}

struct ResolutionItems: Codable {
    let resolutionId: Int
    let content: String
    let createdAt: Date // "2026-01-28T03:19:18.808Z" 형식 대응
}
