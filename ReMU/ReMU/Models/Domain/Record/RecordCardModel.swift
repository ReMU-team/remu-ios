//
//  RecordCardModel.swift
//  ReMU
//
//  Created by 원서우 on 2/1/26.
//

import Foundation
import PhotosUI

/// 카드 UI 전용 모델
struct RecordCardModel {
    let galaxyName: String
    let travelPeriodText: String
    let title: String
    let image: UIImage?
    let dday: Int
    let dateText: String
    let content: String
    let emojis: [String]
}

extension RecordCardModel {
    static func from(
        draft: RecordDraft,
        dday: Int
    ) -> RecordCardModel {
        RecordCardModel(
            galaxyName: "임시 은하",          // TODO: 실제 값으로 교체
            travelPeriodText: "",
            title: draft.title,
            image: draft.image,
            dday: dday,
            dateText: Date().uiFormat,
            content: draft.content,
            emojis: draft.emojis
        )
    }
}

