//
//  CreateGalaxyRequest.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

import Foundation

struct CreateGalaxyRequest: Codable {
    let name: String
    let startDate: String
    let endDate: String
    let emojiResourceName: String
    let googlePlaceId: String
    let placeName: String
}
