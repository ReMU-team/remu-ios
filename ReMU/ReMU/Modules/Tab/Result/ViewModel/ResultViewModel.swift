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
        PledgeItem(title: "아이스크림 사먹기", content: ""),
        PledgeItem(title: "현지인 맛집 찾아가기", content: ""),
        PledgeItem(title: "베스트컷 한 장 찍기", content: "")
    ]
    
    // 여행 후기
    @Published var review: String = ""
    
    // AI결과 생성 함수
    func createFinalResult() -> ReviewResult {
        return ReviewResult(
            galaxyId: 0, // 임시 ID
            travelEmojiImageName: "emoji_name", // 임시 이미지명
            overallContent: review,
            aiFeedback: nil
        )
    }
    
    // MARK: - Emoji
    @Published var isEmojiSheetPresented = false
    @Published var tempSelectedEmojis: [EmojiItem] = []
    @Published var selectedEmojis: [EmojiItem] = []

    let emojis = EmojiCatalog.all

    func confirmEmojiSelection() {
        selectedEmojis = tempSelectedEmojis
        //tempSelectedEmoji = nil
        isEmojiSheetPresented = false
    }

    func openEmojiSheet() {
        //tempSelectedEmoji = selectedEmoji
        isEmojiSheetPresented = true
    }
}
