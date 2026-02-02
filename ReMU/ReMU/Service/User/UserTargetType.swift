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
    case fetchUser(request: PatchUserRequest)
    case verifyDuplicateName(name: String)
    case checkUserProfile
    case deleteUser
    
}

extension UserTargetType: APITargetType {
    
    var path: String {
        switch self {
        case .fetchUser, .checkUserProfile:
                return "/profile"
        case .verifyDuplicateName:
            return "/name/exists"
        case .deleteUser:
            return "/account"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchUser:
            return .patch
        case .verifyDuplicateName, .checkUserProfile:
            return .get
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchUser(request: let request):
            return .requestJSONEncodable(request)
        case .checkUserProfile, .deleteUser:
            return .requestPlain
        case let .verifyDuplicateName(name):
            var params: [String: Any] = ["name": name]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
            
        }
        
    }
}
