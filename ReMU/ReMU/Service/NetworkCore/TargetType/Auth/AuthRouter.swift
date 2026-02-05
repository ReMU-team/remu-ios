//
//  AuthRouter.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation
import Alamofire
import Moya

/// 사용자 인증과 관련된 API 요청을 정의하는 라우터
enum AuthRouter {
    // 리프레쉬 토큰 갱신
    case tokenRefresh(refreshToken: String)
}

extension AuthRouter: APITargetType {
    
    var path: String {
        switch self {
        case .tokenRefresh:
            return "/refresh"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .tokenRefresh:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .tokenRefresh(let refreshToken):
            return .requestJSONEncodable(refreshToken)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .tokenRefresh(let refreshToken) :
            var headers = ["Content-Type": "application/json"]
            headers["Refresh-Token"] = "\(refreshToken)"
            return headers
        }
    }
}
