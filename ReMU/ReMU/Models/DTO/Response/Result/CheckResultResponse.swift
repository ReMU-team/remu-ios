//
//  CheckPledgeResponse.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation

struct CheckResultResponse: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CheckResultData?
}

struct CheckResultData: Decodable {
    let reviewEmojiId: String
    let resolutionEmojiId: String
    let reflection: String
    let reviewList: [CheckReviewResponse]
    let listSize: Int
}

struct CheckReviewResponse: Decodable {
    let reviewId: Int
    let resolutionId: Int
    let resolutionContent: String
    let reviewContent: String
    let isResolutionFulfilled: Bool
    let createdAt: String
}
