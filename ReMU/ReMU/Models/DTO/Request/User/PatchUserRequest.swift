//
//  PatchUserRequest.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

struct PatchUserRequest: Codable {
    let name : String
    let introduction : String?
    let imageData: Data?
}
