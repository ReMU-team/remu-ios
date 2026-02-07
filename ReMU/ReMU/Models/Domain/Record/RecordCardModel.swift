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
    
    // API DTO -> 카드 UI 모델 변환
    static func from(
            dto: StarDetailResponse,
            galaxy: Galaxy?
        ) -> RecordCardModel {

            RecordCardModel(
                galaxyName: galaxy?.title ?? "",
                travelPeriodText: "", // 필요하면 start~end 가공
                title: dto.title,
                image: nil, // imageUrl → UIImage는 다음 단계
                dday: dto.dday,
                dateText: dto.recordDate,
                content: dto.content,
                emojis: dto.emojis
            )
        }
}

