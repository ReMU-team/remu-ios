//
//  ResultViewModel.swift
//  ReMU
//
//  Created by 원서우 on 1/28/26.
//

import Foundation
import Combine
import SwiftUI

class ResultViewModel: ObservableObject {
    
    // 다짐 목록 (PledgeItem은 ReviewResult.swift에 정의됨)
    @Published var pledges: [PledgeItem] = [
        PledgeItem(title: "다짐 1", content: ""),
        PledgeItem(title: "다짐 2", content: "")
    ]
    
    // 여행 후기
    @Published var review: String = ""
    
    // 결과 생성 함수
    func createFinalResult() -> ReviewResult {
        return ReviewResult( // TripReviewResult -> ReviewResult로 이름 통일
            galaxyId: 0, // 임시 ID
            travelEmojiImageName: "emoji_name", // 임시 이미지명
            overallContent: review,
            aiFeedback: nil
        )
    }
}
