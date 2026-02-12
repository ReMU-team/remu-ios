//
//  PatchPledgeRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

struct PatchPledgeRequest: Codable {
    let emojiId: String?
    let resolutions: [PatchResolutionItem]
}

