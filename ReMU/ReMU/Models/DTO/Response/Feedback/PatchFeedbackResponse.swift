//
//  PatchFeedbackResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation

struct PatchFeedbackResult: Codable {
    let content: String
    let updatedAt: String
}

typealias PatchFeedbackResponse = BaseResponse<PatchFeedbackResult>
