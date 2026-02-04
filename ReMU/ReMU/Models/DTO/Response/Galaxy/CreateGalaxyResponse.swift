//
//  CreateGalaxyResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct CreateGalaxyResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: CreateGalaxyItem
}

struct CreateGalaxyItem : Codable {
    let galaxyId: Int
    let name: String
    let startDate: String
    let arrivalDate: String
    let endDate: String
}
