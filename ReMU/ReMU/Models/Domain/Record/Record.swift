//
//  Record.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Record: Identifiable {
    let id: Int
    let galaxyId: Int

    let title: String?
    let content: String?

    let cardColor: RecordColor
    let emojiImageNames: [String]   // 최대 3개 (asset name)
    let photoImageName: String?     // 사진 1장

    let createdAt: Date
}

enum RecordColor {
    case yellow
    case blue
    case purple
}
