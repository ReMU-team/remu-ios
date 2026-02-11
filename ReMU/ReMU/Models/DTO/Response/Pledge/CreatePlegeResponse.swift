//
//  CreatePlegeResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct CreatePledgeResult: Codable {
    let emojiId: String
    let illustId: String
    let resolutions: [ResolutionItem]
}

typealias CreatePledgeResponse = BaseResponse<CreatePledgeResult>

