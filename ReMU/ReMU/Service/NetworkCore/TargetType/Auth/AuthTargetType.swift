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
    case socialLogout(refreshToken: String)
    case tokenRefresh(refreshToken: String)
}

extension AuthTargetType: APITargetType {
    var path: String {
        switch self {
        case .socialLogout:
            return "/logout"
        case .tokenRefresh:
            return "/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .socialLogout, .tokenRefresh:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .socialLogout(let refreshToken), .tokenRefresh(let refreshToken):
            return .requestJSONEncodable(refreshToken)
        }
    }
    
    var sampleData: Data {
        switch self {
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
