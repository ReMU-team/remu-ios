//
//  ResultCardModel.swift
//  ReMU
//
//  Created by 원서우 on 1/30/26.
//

import Foundation

struct ResultCard: Identifiable {
    let id = UUID()
    let galaxyServerId: Int

    let pledgeEmojiImageName: String
    let resultEmojiImageName: String
    
    let reviewText: String // 여행 후 회고
    let aiFeedback: String // AI 피드백
}
