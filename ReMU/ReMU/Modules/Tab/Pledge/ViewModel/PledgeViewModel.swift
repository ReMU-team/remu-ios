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

@MainActor
final class PledgeViewModel: ObservableObject {

    // MARK: - Pledge Count
    let minCount = 1
    let maxCount = 5

    // MARK: - Pledge Drafts
    @Published var pledges: [PledgeDraft] = [
        PledgeDraft(content: "", example: "예시: 외국인이랑 스몰토킹하기")
    ]

    private let examples = [
        "예시: 외국인이랑 스몰토킹하기",
        "예시: 현지인 맛집 찾아가기",
        "예시: 하루를 한 줄로 기록하기",
        "예시: 사진 한 장은 꼭 남기기",
        "예시: 나에게 선물 하나 사기"
    ]

    // MARK: - Emoji
    let emojis: [EmojiItem] = EmojiCatalog.all

    /// 시트 표시 여부
    @Published var isEmojiSheetPresented = false

    /// 시트 내부 임시 선택 (공용 시트용)
    @Published var tempSelectedEmojis: [EmojiItem] = []

    /// 최종 선택 (이 화면에서는 1개만 사용)
    @Published var selectedEmojis: [EmojiItem] = []

    /// 화면에서 쓰는 단일 이모지
    var selectedEmoji: EmojiItem? {
        selectedEmojis.first
    }

    // MARK: - Button State
    var canAdd: Bool { pledges.count < maxCount }
    var canRemove: Bool { pledges.count > minCount }

    var isNextEnabled: Bool {
        selectedEmoji != nil &&
        pledges.allSatisfy {
            !$0.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    // MARK: - Pledge Actions
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

    // MARK: - Emoji Sheet Control

    /// 이모지 시트 열기 (기존 선택 복사)
    func openEmojiSheet() {
        tempSelectedEmojis = selectedEmojis
        isEmojiSheetPresented = true
    }

    /// 이모지 선택 확정
    func confirmEmojiSelection() {
        selectedEmojis = tempSelectedEmojis
        isEmojiSheetPresented = false
    }

    // MARK: - Card Conversion
    func makePledgeCard(galaxyId: Int) -> PledgeCard {
        PledgeCard(
            galaxyServerId: galaxyId,
            emojiImageName: selectedEmoji?.id ?? "",
            pledges: pledges.map {
                Pledge(content: $0.content)
            }
        )
    }
}
