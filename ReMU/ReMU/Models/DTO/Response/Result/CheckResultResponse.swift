//
//  CheckPledgeResponse.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation

struct CheckResultResponse: Decodable {
    let galaxyId: Int
    let galaxyTitle: String?
    let travelDate: String?
    let travelEmojiImageName: String?
    let overallContent: String?
    let aiFeedback: String?
    let reviews: [CheckReviewResponse]
}


struct CheckReviewResponse: Decodable {
    let reviewId: Int
    let title: String
    let content: String
    let isResolutionFulfilled: Bool
}
