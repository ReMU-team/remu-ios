//
//  GetFeedbackResponse.swift
//  ReMU
//
//  Created by 원서우 on 2/20/26.
//

import Foundation

struct GetFeedbackResult: Codable {
    let content: String
    let createdAt: String?
    let updatedAt: String?
}

typealias GetFeedbackResponse = BaseResponse<GetFeedbackResult>
