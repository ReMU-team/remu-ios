//
//  AuthAPI.swift
//  ReMU
//
//  Created by 원서우 on 1/25/26.
//

import Foundation
import Moya
import Alamofire

enum AuthTargetType {
    case socialLogin
    case socialLogout(refreshToken: String)
    case tokenRefresh(refreshToken: String)
}

extension AuthTargetType: APITargetType {
    var path: String {
        switch self {
        case .socialLogin:
            return "/login"
        case .socialLogout:
            return "/logout"
        case .tokenRefresh:
            return "/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socialLogin, .socialLogout, .tokenRefresh:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogin,.socialLogout:
            return .requestPlain
        case .tokenRefresh(let refreshToken):
            return .requestJSONEncodable(refreshToken)
        }
    }
    
    var sampleData: Data {
        switch self {
        case .socialLogin:
            let json = """
                    "isSuccess": true,
                    "code": "string",
                    "message": "string",
                    "result": {
                      "accessToken": "string",
                      "refreshToken": "string",
                      "isNewUser": true 
                    }
                """
            return Data(json.utf8)
        case .socialLogout:
            let json = """
                  "isSuccess": true,
                  "code": "200", 
                  "message": "로그아웃 성공",
                  "result": null
                """
            return Data(json.utf8)
        case .tokenRefresh:
            return Data()
        }
    }
}
