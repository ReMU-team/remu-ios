//
//  RecordCardModel.swift
//  ReMU
//
//  Created by 원서우 on 2/1/26.
//

import Foundation

struct RecordCard: Identifiable {
    let id = UUID()
    let galaxyServerId: Int

    let EmojiImageName: [RecordEmojies]
}

struct RecordEmojies: Identifiable {
    let id = UUID()
    
    let emoji: String
}
