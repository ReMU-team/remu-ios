//
//  UserResponse.swift
//  ReMU
//
//  Created by 원서우 on 1/14/26.
//

import Foundation

struct UserProfileResponse: Decodable {
    let name: String
    let introduction: String?
    let imageUrl: String?
}
