//
//  PledgeModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation

struct Pledge: Identifiable, Hashable {
    let id: UUID
    var content: String
    var emoji: String?
    
    init(
        id: UUID = UUID(),
        content: String,
        emoji: String? = nil
    ) {
        self.id = id
        self.content = content
        self.emoji = emoji
    }
}
