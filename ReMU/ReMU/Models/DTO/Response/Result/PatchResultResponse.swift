//
//  PatchResultResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

// 최상위 응답 객체
struct patchResultResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: patchResultItem?
}

// 결과 데이터 객체
struct patchResultItem: Codable {
    let reviewEmojiId: String
    let resolutionEmojiId: String
    let reflection: String
    let reviews: [patchResultReviewDetail]
}

// 개별 리뷰 상세 객체
struct patchResultReviewDetail: Codable {
    let resolutionId: Int
    let resolutionContent: String
    let reviewId: Int
    let reviewContent: String
    let isResolutionFulfilled: Bool
    let updatedAt: String // ISO8601 형식을 Date로 파싱
}
