//
//  PatchResultRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct patchResultRequest: Codable {
    let emojiId: String
    let reflection: String
    let reviews: [patchresultDetail]
}

struct patchresultDetail: Codable {
    let reviewId: Int
    let reviewContent: String
    let isResolutionFulfilled: Bool
}
