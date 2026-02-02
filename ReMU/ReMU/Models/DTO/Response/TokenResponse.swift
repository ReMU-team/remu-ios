//
//  TokenResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

struct TokenResponse: Codable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: UserInfo
}
