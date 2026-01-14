//
//  PledgeModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

//import Foundation
//
//struct Pledge: Identifiable, Hashable {
//    let id: UUID
//    var content: String // 사용자가 입력한 다짐
//    var example: String // 하단에 보여줄 예시 문구
//    var emoji: String? // 선택한 이모지
//    
//    init(
//        id: UUID = UUID(),
//        content: String,
//        example: String,
//        emoji: String? = nil
//    ) {
//        self.id = id
//        self.content = content
//        self.example = example
//        self.emoji = emoji
//    }
//}


import Foundation

/// 실제 다짐 카드에 저장/표시되는 단일 다짐
struct Pledge: Identifiable {
    let id = UUID()
    let content: String
}
