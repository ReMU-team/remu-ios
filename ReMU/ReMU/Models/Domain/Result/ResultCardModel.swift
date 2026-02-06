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
    
    let reviews: [Review]
    let reflection: String
    let aiFeedback: String
}

struct Review: Identifiable {
    let id: Int                 // reviewId
    let pledgeId: Int           // 다짐 ID

    let pledgeContent: String   // 다짐 내용
    var reviewContent: String   // 회고 내용
    var isFulfilled: Bool
}


