//
//  CheckPledgeResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct CheckPledgeResult: Codable {
    let emojiId: String
    let resolutionList: [ResolutionItem]
    let listSize: Int
}

typealias CheckPledgeResponse = BaseResponse<CheckPledgeResult>



