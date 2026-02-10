//
//  CreateGalaxyRequest.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

import Foundation

struct CreateGalaxyRequest: Codable {
    let name: String
    let startDate: Date
    let endDate: Date
    let emojiResourceName: String
    let googlePlaceId: String
    let placeName: String
}
