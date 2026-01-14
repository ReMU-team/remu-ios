//
//  PledgeViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

//import Foundation
//import Combine
//
//final class PledgeViewModel: ObservableObject {
//    
//    private let examples = [
//            "예시: 외국인이랑 스몰토킹하기",
//            "예시: 친구랑 진지한 대화 나누고 오기",
//            "예시: 하루가 끝나면 한 줄씩 그날 기록하기",
//            "예시: 현지인 맛집 찾아가기",
//            "예시: 베스트컷 한 장 찍기"
//        ]
//    
//    @Published var pledges: [Pledge] = [
//        Pledge(
//            content: "",
//            example: "예시: 외국인이랑 스몰토킹하기")
//    ]
//
//    // 다짐 최소값, 최대값
//    let minCount = 1
//    let maxCount = 5
//
//    var canAdd: Bool {
//        pledges.count < maxCount
//    }
//
//    var canRemove: Bool {
//        pledges.count > minCount
//    }
//
//    func addPledge() {
//        guard canAdd else { return }
//        
//        let index = pledges.count % examples.count
//        pledges.append(
//            Pledge(content: "", example: examples[index])
//        )
//    }
//
//    func removePledge(at index: Int) {
//        guard canRemove else { return }
//        pledges.remove(at: index)
//    }
//
//    func updateContent(_ text: String, at index: Int) {
//        pledges[index].content = text
//    }
//
//    func updateEmoji(_ emoji: String, at index: Int) {
//        pledges[index].emoji = emoji
//    }
//
//    var isNextEnabled: Bool {
//        pledges.allSatisfy { !$0.content.trimmingCharacters(in: .whitespaces).isEmpty }
//    }
//}

import Foundation
import Combine

/// 다짐 작성 화면 전용 ViewModel
/// - 다짐 개수 제한 (1~5)
/// - + / − 버튼 활성화 제어
/// - "다음" 버튼 활성화 판단
/// - Draft -> Card 변환 담당
final class PledgeViewModel: ObservableObject {

    // MARK: - Constants
    private let examples = [
        "예시: 외국인이랑 스몰토킹하기",
        "예시: 현지인 맛집 찾아가기",
        "예시: 하루를 한 줄로 기록하기",
        "예시: 사진 한 장은 꼭 남기기",
        "예시: 나에게 선물 하나 사기"
    ]

    let minCount = 1
    let maxCount = 5

    // MARK: - Draft (입력 상태)
    @Published var pledges: [PledgeDraft] = [
        PledgeDraft(
            content: "",
            example: "예시: 외국인이랑 스몰토킹하기"
        )
    ]

    // MARK: - Emoji
    @Published var selectedEmoji: String? = nil
    @Published var isEmojiSheetPresented: Bool = false

    // MARK: - Computed States
    /// 다짐 추가 가능 여부
    var canAdd: Bool {
        pledges.count < maxCount
    }

    /// 다짐 삭제 가능 여부
    var canRemove: Bool {
        pledges.count > minCount
    }

    /// 모든 다짐이 비어있지 않을 때만 다음 가능
    var isNextEnabled: Bool {
        pledges.allSatisfy {
            !$0.content
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .isEmpty
        }
    }

    // MARK: - Actions
    /// 다짐 추가
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

    /// 마지막 다짐 삭제
    func removeLastPledge() {
        guard canRemove else { return }
        pledges.removeLast()
    }

    /// 이모지 선택
    func selectEmoji(_ emoji: String) {
        selectedEmoji = emoji
        isEmojiSheetPresented = false
    }

    // MARK: - Convert Draft -> Card
    /// 다짐 작성 완료 시 호출
    /// 작성 중 상태(Draft)를 -> 저장 가능한 카드(Card)로 바꿔주는 변환기
    func makePledgeCard(tripId: UUID) -> PledgeCard {
        let resultPledges = pledges.map {
            Pledge(content: $0.content)
        }

        return PledgeCard(
            tripId: tripId,
            emoji: selectedEmoji ?? "✨", // TODO: 기본 이모지 수정 필요
            pledges: resultPledges
        )
    }
}
