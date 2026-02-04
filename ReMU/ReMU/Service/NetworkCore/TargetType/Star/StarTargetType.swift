//
//  StarTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation
import Moya
import Alamofire

enum StarTargetType {
    // TODO: MultiPart-Form 형태로 수정 필요함
    case createStar(accessToken: String, request: CreateStarRequest)
    case fetchStarsList(accessToken: String, galaxyId: Int)
    case fetchStarDetail(accessToken: String, starId: Int)
    // TODO: MultiPart-Form 형태로 이미지 수정 필요함
    case patchStar(accessToken: String, request: PatchStarRequest ,starId: Int)
    case deleteStar(accessToken: String, starId: Int)
}

extension StarTargetType: APITargetType {
    var path: String {
        switch self {
        case .createStar:
            return "/api/v1/stars"
        case .fetchStarsList(_, let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/stars"
        case .fetchStarDetail(_, let starId):
            return "/api/v1/stars/\(starId)"
        case .patchStar(_,_,let starId):
            return "/api/v1/stars/\(starId)"
        case .deleteStar(_, let starId):
            return "/api/v1/stars/\(starId)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .createStar:
            return .post
        case .fetchStarDetail, .fetchStarsList:
            return .get
        case .patchStar:
            return .patch
        case .deleteStar:
            return .delete
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .createStar(let accessToken,_),
                .fetchStarsList(let accessToken,_),
                .fetchStarDetail(let accessToken,_),
                .patchStar(let accessToken, _, _),
                .deleteStar(accessToken: let accessToken, starId: _):
            var header = ["Accept": "application/json"]
            header["Authorization"] = "Bearer \(accessToken)"
            return header
        }
    }
    // TODO: 수정 필요
    var task: Moya.Task {
        return .requestPlain
        }
    }
