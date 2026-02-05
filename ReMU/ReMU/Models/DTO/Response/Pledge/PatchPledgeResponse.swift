//
//  PatchPledgeResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct PatchPledgeResult: Codable {
    let emojiId: String
    let illustId: String
    let contents: [String]
}

typealias PatchPledgeResponse = BaseResponse<PatchPledgeResult>
