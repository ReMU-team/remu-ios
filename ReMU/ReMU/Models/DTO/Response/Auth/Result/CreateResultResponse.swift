//
//  CreateResultResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

// 최상위 응답 객체
struct createResultResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: createResultItem
}

// 결과 데이터 객체
struct createResultItem: Codable {
    let reviewEmojiId: String
    let resolutionEmojiId: String
    let reflection: String
    let reviews: [createResultDetail]
}

// 개별 리뷰 상세 객체
struct createResultDetail: Codable {
    let resolutionId: Int
    let resolutionContent: String
    let reviewId: Int
    let reviewContent: String
    let isResolutionFulfilled: Bool
    let createdAt: String // String 대신 Date로 처리 가능
}
