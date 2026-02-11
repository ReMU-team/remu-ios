//
//  UserAPI.swift
//  ReMU
//
//  Created by 원서우 on 1/14/26.
//

import Foundation
import Alamofire
import Moya

enum UserAPI {
    // 소셜 로그인
    // provider 예시: "kakao", "apple", "google"
    case socialLogin(provider: String, token: String)
    
    // 내 프로필 조회 (로그인 후 사용)
    case getMyProfile
}

extension UserAPI: TargetType {
    
    // 주소 - URL
    var baseURL: URL {
        return URL(string: "https://remu-travel.com")!
    }
    
    // 주소 - 경로
    var path: String {
        switch self {
        case .socialLogin(let provider, _):
            // 예시: /auth/kakao/login 또는 /auth/login/apple
            return "/api/v1/auth/login/\(provider)"
        case .getMyProfile:
            return "/user/me"
        }
    }
    
    // 요청 행동 - HTTP 메서드
    var method: Moya.Method {
        switch self {
        case .socialLogin:
            return .post // 데이터 전송은 POST
        case .getMyProfile:
            return .get
        }
    }
    
    // 요청 정보 - 바디
    var task: Task {
        switch self {
        case .socialLogin(_, let token):
            // 서버 개발자가 원하는 키 값("access_token" 등)에 맞춰서 보냄
            let params: [String: Any] = [
                "token": token
            ]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .getMyProfile:
            // 로그인 된 상태라면 토큰은 Header에 실리므로 body는 비워둠
            return .requestPlain
        }
    }
    
    // 요청 정보 - 헤더
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    // 테스트용 데이터
    var sampleData: Data {
        switch self {
        case .socialLogin:
            return """
            {
                "accessToken": "remu_jwt_token_example",
                "isNewUser": true
            }
            """.utf8Encoded
        case .getMyProfile:
            return """
            { "id": 1, "nickname": "소셜아요" }
            """.utf8Encoded
        default:
            return Data()
        }
    }
}
