//
//  PledgeCardModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation

///// 하나의 여행(은하)에 귀속되는 다짐 카드
//struct PledgeCard: Identifiable {
//    let id = UUID()
//    let tripId: UUID        // 어떤 여행(은하)에 속하는지
//    let emojiId: String       // 카드 대표 이모지
//    let pledges: [Pledge]  // 다짐 목록 (1~5)
//}

/// 하나의 은하(여행)에 귀속되는 다짐 카드 (은하당 1개)
struct PledgeCardModel: Identifiable {
    let id: UUID = UUID()
    let galaxy: Galaxy
    let emojiImageName: String   // 다짐 이모지 (asset name)
    let pledges: [Pledge]        // 다짐 목록 (1~5)
}
