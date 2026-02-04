//
//  UserApiTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation
import Alamofire
import Moya

enum UserTargetType {
    case patchUser(request: PatchUserRequest)
    case verifyDuplicateName(name: String)
    case checkUserProfile
    case deleteUser
    
}

extension UserTargetType: APITargetType {
    
    var path: String {
        switch self {
        case .patchUser, .checkUserProfile:
                return "/profile"
        case .verifyDuplicateName:
            return "/name/exists"
        case .deleteUser:
            return "/account"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .patchUser:
            return .patch
        case .verifyDuplicateName, .checkUserProfile:
            return .get
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .patchUser(request: let request):
            return .requestJSONEncodable(request)
        case .checkUserProfile, .deleteUser:
            return .requestPlain
        case let .verifyDuplicateName(name):
            var params: [String: Any] = ["name": name]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        }
        
    }
    
    var sampleData: Data {
        return Data("""
            {
              "isSuccess": true,
              "code": "200",
              "message": "success",
                "imageUrl": "string",
                "name": "종수",
                "introduction": "빡세다"
            }
            """.utf8)
    }
}
