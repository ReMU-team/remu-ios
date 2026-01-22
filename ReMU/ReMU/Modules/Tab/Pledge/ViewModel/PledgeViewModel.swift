//
//  PledgeViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation
import Combine

/// 다짐 작성 화면 전용 ViewModel
/// - 다짐 개수 제한 (1~5)
/// - + / − 버튼 활성화 제어
/// - "다음" 버튼 활성화 판단
/// - Draft -> Card 변환 담당

final class PledgeViewModel: ObservableObject {
    
    let minCount = 1
    let maxCount = 5

    @Published var pledges: [PledgeDraft] = [
        PledgeDraft(content: "", example: "예시: 외국인이랑 스몰토킹하기")
    ]

    @Published var isEmojiSheetPresented = false
    @Published var tempSelectedEmoji: EmojiItem?
    @Published var selectedEmoji: EmojiItem?

    private let examples = [
            "예시: 외국인이랑 스몰토킹하기",
            "예시: 현지인 맛집 찾아가기",
            "예시: 하루를 한 줄로 기록하기",
            "예시: 사진 한 장은 꼭 남기기",
            "예시: 나에게 선물 하나 사기"
        ]
    
    let emojis = EmojiCatalog.all

    var canAdd: Bool { pledges.count < maxCount }
    var canRemove: Bool { pledges.count > minCount }

    var isNextEnabled: Bool {
        selectedEmoji != nil &&
        pledges.allSatisfy {
            !$0.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    func addPledge() {
        guard canAdd else { return }
        
        let index = pledges.count % examples.count
        pledges.append(
            PledgeDraft(
                content: "",
                example: examples[index]
            )
        )
    }
    
    func removeLastPledge() {
        guard canRemove else { return }
        pledges.removeLast()
    }

    func confirmEmojiSelection() {
        selectedEmoji = tempSelectedEmoji
        tempSelectedEmoji = nil
        isEmojiSheetPresented = false
    }

    func makePledgeCard(galaxyId: Int) -> PledgeCard {
        PledgeCard(
            galaxyId: galaxyId,
            emojiImageName: selectedEmoji!.id,
            pledges: pledges.map { Pledge(content: $0.content) }
        )
    }
}

