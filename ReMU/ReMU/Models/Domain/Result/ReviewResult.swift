//
//  ReviewResult.swift
//  ReMU
//
//  Created by 원서우 on 1/28/26.
//

import Foundation

// 1. 다짐 상태 열거형
enum PledgeStatus {
    case none
    case success
    case fail
}

// 2. 개별 다짐 데이터 모델
struct PledgeItem: Identifiable {
    let id = UUID()          // UI용
    let reviewId: Int        // 서버용 (PATCH 필수)
    let title: String
    var content: String
    var status: PledgeStatus = .none
}

extension PledgeItem {
    var isFulfilled: Bool {
        status == .success
    }
}


// 3. 최종 결과 모델 (이전의 Result 구조체 대체)
struct ReviewResult {
    let galaxyId: Int
    let travelEmojiImageName: String   // 여행 후 이모지
    let overallContent: String?        // 여행 후기
    let aiFeedback: String?            // AI 분석 결과
}
