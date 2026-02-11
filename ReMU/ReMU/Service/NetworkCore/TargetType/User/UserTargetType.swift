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
                return "api/v1/users/profile"
        case .verifyDuplicateName:
            return "api/v1/users/names/availability"
        case .deleteUser:
            return "api/v1/users/account"
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

        case .patchUser(let request):
            var multipartData: [Moya.MultipartFormData] = []

            // name (required)
            multipartData.append(
                Moya.MultipartFormData(
                    provider: .data(request.name.data(using: .utf8)!),
                    name: "name"
                )
            )

            // introduction (optional)
            if let intro = request.introduction {
                multipartData.append(
                    Moya.MultipartFormData(
                        provider: .data(intro.data(using: .utf8)!),
                        name: "introduction"
                    )
                )
            }

            // image (optional)
            if let imageData = request.imageData {
                multipartData.append(
                    Moya.MultipartFormData(
                        provider: .data(imageData),
                        name: "image",
                        fileName: "profile.jpg",
                        mimeType: "image/jpeg"
                    )
                )
            }

            return .uploadMultipart(multipartData)

        case .checkUserProfile, .deleteUser:
            return .requestPlain

        case let .verifyDuplicateName(name):
            return .requestParameters(
                parameters: ["name": name],
                encoding: URLEncoding.default
            )
        }
    }

    
    var sampleData: Data {
        return Data("""
        {
          "isSuccess": true,
          "code": "200",
          "message": "success",
          "result": {
            "name": "종수",
            "introduction": "빡세다",
            "imageUrl": "string"
          }
        }
        """.utf8)
    }

}
