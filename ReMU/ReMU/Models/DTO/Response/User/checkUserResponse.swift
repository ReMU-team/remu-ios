//
//  checkUserResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/3/26.
//

import Foundation

struct checkUserResponse: Codable {
    let isSuccess: Bool
    let code: String
    let Message: String
    let result: [checkUserResult]

}

struct checkUserResult: Codable {
    let name: String
    let introduction: String
    let imageURL: String
}
