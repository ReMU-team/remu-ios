//
//  Result.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Result {
    let galaxyId: Int

    let travelEmojiImageName: String   // 여행 후 이모지 (asset name)
    let overallContent: String?        // 여행 후기
    let aiFeedback: String?            // AI 분석 결과
}
