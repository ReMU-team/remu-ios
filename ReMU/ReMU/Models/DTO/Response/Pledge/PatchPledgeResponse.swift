//
//  PatchPledgeResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct PatchPledgeResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: PatchPledgeResult
}

struct PatchPledgeResult: Codable {
    let emojiId: String
    let illustId: String
    let contents: [String]
}
