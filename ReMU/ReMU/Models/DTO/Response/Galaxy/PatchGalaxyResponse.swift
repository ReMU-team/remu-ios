//
//  PatchGalaxyResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation

struct PatchGalaxyResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: String
}

