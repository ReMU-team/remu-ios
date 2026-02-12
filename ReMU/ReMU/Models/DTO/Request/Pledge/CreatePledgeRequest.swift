//
//  CreatePledgeRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

struct CreatePledgeRequest: Codable {
    let emojiId: String
    let illustId: String
    let contents: [String]
}
