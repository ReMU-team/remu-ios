//
//  PledgeDraftModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation

/// 다짐 작성 단계에서 사용하는 임시 모델
/// - UI 상태 전용
/// - example은 입력 힌트용 (카드/서버 X)
//struct PledgeDraft: Identifiable, Equatable {
//    let id = UUID()
//    var content: String
//    let example: String
//}

struct PledgeDraft {
    let resolutionId: Int? // 수정 화면에서만 의미 있음
    var content: String
    let example: String
}

