//
//  ResultTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/2/26.
//

import Foundation
import Alamofire
import Moya

enum ResultTargetType {
    case createResult(galaxyId: Int, request:createResultRequest)
    case checkResult(galaxyId: Int)
    case patchResult(galaxyId: Int, request:patchResultRequest)
}

extension ResultTargetType: APITargetType {
    var path: String {
        switch self {
        case .createResult(let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)/reviews"
        case .checkResult(let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/reviews"
        case .patchResult(let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)/reviews"
        }
    }
    var method: Moya.Method {
        switch self {
        case .createResult:
            return .post
        case .checkResult:
            return .get
        case .patchResult:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .createResult(_,let request):
            return .requestJSONEncodable(request)
        case .patchResult(_,let request):
            return .requestJSONEncodable(request)
        case .checkResult:
            return .requestPlain
        }
    }
}
