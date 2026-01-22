//
//  Record.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Record: Identifiable {
    let id: Int     // 이 기록 자체의 고유 ID (recordId)
    let galaxyId: Int    // 이 기록이 속한 은하의 ID (galaxyId)

    let title: String?
    let content: String?

    let starImageName: String   // 별 이미지 asset name
    let emojiImageNames: [String]   // 최대 3개 (asset name)
    let photoUrl: String?     // 사진 1장

    let createdAt: Date
}

enum RecordColor {
    case yellow
    case blue
    case purple
}
