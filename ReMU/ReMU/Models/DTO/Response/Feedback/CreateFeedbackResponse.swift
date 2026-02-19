//
//  CreateFeedbackResponse.swift
//  ReMU
//
//  Created by 원서우 on 2/20/26.
//

import Foundation

struct FeedbackResult: Codable {
    let content: String
    let createdAt: String
}

typealias FeedbackResponse = BaseResponse<FeedbackResult>
