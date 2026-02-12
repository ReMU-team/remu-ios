//
//  UserDTO.swift
//  ReMU
//
//  Created by 원서우 on 1/25/26.
//

import Foundation

/// keychan 저장
struct UserInfo: Codable {
    var accessToken: String?
    var refreshToken: String?
    var isNewUser: Bool?
}

