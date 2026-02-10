//
//  CreateGalaxyResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct CreateGalaxyItem : Codable {
    let galaxyId: Int
    let name: String
    let startDate: String
    let endDate: String
}

typealias CreateGalaxyResponse = BaseResponse<CreateGalaxyItem>
