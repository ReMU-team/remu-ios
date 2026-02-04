//
//  LoginResponse.swift
//  ReMU
//
//  Created by 원서우 on 1/14/26.
//

import Foundation

struct LoginResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
