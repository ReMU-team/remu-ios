//
//  PledgeViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation
import Combine

final class PledgeViewModel: ObservableObject {
    
    private let examples = [
            "예시: 외국인이랑 스몰토킹하기",
            "예시: 친구랑 진지한 대화 나누고 오기",
            "예시: 하루가 끝나면 한 줄씩 그날 기록하기",
            "예시: 현지인 맛집 찾아가기",
            "예시: 베스트컷 한 장 찍기"
        ]
    
    @Published var pledges: [Pledge] = [
        Pledge(
            content: "",
            example: "예시: 외국인이랑 스몰토킹하기")
    ]

    // 다짐 최소값, 최대값
    let minCount = 1
    let maxCount = 5

    var canAdd: Bool {
        pledges.count < maxCount
    }

    var canRemove: Bool {
        pledges.count > minCount
    }

    func addPledge() {
        guard canAdd else { return }
        
        let index = pledges.count % examples.count
        pledges.append(
            Pledge(content: "", example: examples[index])
        )
    }

    func removePledge(at index: Int) {
        guard canRemove else { return }
        pledges.remove(at: index)
    }

    func updateContent(_ text: String, at index: Int) {
        pledges[index].content = text
    }

    func updateEmoji(_ emoji: String, at index: Int) {
        pledges[index].emoji = emoji
    }

    var isNextEnabled: Bool {
        pledges.allSatisfy { !$0.content.trimmingCharacters(in: .whitespaces).isEmpty }
    }
}
