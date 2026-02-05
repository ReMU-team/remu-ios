//
//  CreateStarRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation

struct CreateStarRequest: Codable{
    let title: String        // 2~32자
    let content: String      // 2자 이상
    let recordDate: String   // yyyy-MM-dd
    let cardColor: String    // 예: "PURPLE"
    let emojis: [String]     // 최대 3개, 선택 사항
    let galaxyId: Int64      // Long 타입 대응
}
