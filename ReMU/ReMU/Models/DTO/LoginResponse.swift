//
//  LoginResponse.swift
//  ReMU
//
//  Created by 원서우 on 1/14/26.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String
    let isNewUser: Bool
}
