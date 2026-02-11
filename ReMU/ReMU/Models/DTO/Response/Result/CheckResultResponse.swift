//
//  CheckPledgeResponse.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation

struct CheckResultResponse: Decodable {
    let galaxyId: Int
    let travelEmojiImageName: String
    let overallContent: String
    let aiFeedback: String?
}
