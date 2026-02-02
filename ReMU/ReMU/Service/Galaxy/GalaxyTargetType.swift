//
//  GalaxyTargetType.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

import Foundation
import Alamofire
import Moya

enum GalaxyTargetType {
    case fetchGalaxyDetail(galaxyId: Int)
    case fetchGalaxyList(userId: Int, page: Int, size: Int)
    case createGalaxy(requset: CreateGalaxyRequest)
    case patchGalaxy(galaxyId: Int,request: PatchGalaxyRequest)
    case deleteGalaxy(galaxyId: Int)
    
}

extension GalaxyTargetType: APITargetType {
    
    
    var path: String {
        switch self {
        case .fetchGalaxyDetail(let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)"
        case .fetchGalaxyList:
            return "/api/v1/galaxies"
        case .createGalaxy:
            return "/api/v1/galaxies"
        case .patchGalaxy(let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)"
        case .deleteGalaxy(let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)"
        }
    }
    var method: Moya.Method {
        switch self {
        case .fetchGalaxyDetail, .fetchGalaxyList:
            return .get
        case .createGalaxy:
            return .post
        case .patchGalaxy:
            return .patch
        case .deleteGalaxy:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .fetchGalaxyDetail, .deleteGalaxy:
            return .requestPlain
        case let .fetchGalaxyList(userId, page, size):
            var params: [String: Any] = [
                "userId": userId,
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .createGalaxy(let request):
            return .requestJSONEncodable(request)
            
        case .patchGalaxy(_,let request):
            return .requestJSONEncodable(request)
        }
    }
}
