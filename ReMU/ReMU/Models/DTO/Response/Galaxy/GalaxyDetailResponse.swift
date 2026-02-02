//
//  GalaxyDetailResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct GalaxyDetailResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: GalaxyDetailItem
}

struct GalaxyDetailItem: Codable {
    let galaxyId: Int
    let name: String
    let emojiResourceName: String
    let dDay: Int
    let startDate: String // "2026-01-27" 형식
    let arrivalDate: String
    let endDate: String
    let placeName: String
}
