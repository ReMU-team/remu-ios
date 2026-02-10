//
//  FeedbackRequest.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation

struct FeedbackRequest: Encodable {
    let reviews: [FeedbackReviewRequest]
}

struct FeedbackReviewRequest: Encodable {
    let pledgeId: Int
    let pledgeContent: String
    let reviewContent: String
    let isFulfilled: Bool
}
