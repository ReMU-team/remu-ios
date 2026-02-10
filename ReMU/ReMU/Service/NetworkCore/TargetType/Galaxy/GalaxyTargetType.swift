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
    case fetchGalaxyDetail(accessToken: String, galaxyId: Int)
    case fetchGalaxyList(accessToken: String, page: Int, size: Int)
    case createGalaxy(accessToken: String, requset: CreateGalaxyRequest)
    case patchGalaxy(accessToken: String, galaxyId: Int,request: PatchGalaxyRequest)
    case deleteGalaxy(accessToken: String, galaxyId: Int)
    
}

extension GalaxyTargetType: APITargetType {
    
    
    var path: String {
        switch self {
        case .fetchGalaxyDetail(_,let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)"
        case .fetchGalaxyList:
            return "/api/v1/galaxies"
        case .createGalaxy:
            return "/api/v1/galaxies"
        case .patchGalaxy(_,let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)"
        case .deleteGalaxy(_,let galaxyId):
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
    
    var headers: [String : String]? {
        switch self {
        case .fetchGalaxyDetail(let accessToken,_), .fetchGalaxyList(let accessToken,_,_), .createGalaxy(let accessToken,_), .patchGalaxy(let accessToken,_,_), .deleteGalaxy(let accessToken,_):
            var header = ["Accept": "application/json"]
            header["Authorization"] = "Bearer \(accessToken)"
            return header
        }
    }
    var task: Moya.Task {
        switch self {
        case .fetchGalaxyDetail, .deleteGalaxy:
            return .requestPlain
        case let .fetchGalaxyList(_, page, size):
            let params: [String: Any] = [
                "page": page,
                "size": size
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .createGalaxy(_,let request):
            return .requestJSONEncodable(request)
            
        case .patchGalaxy(_,_,let request):
            return .requestJSONEncodable(request)
        }
    }
    var sampleData: Data {
        switch self {
        case .fetchGalaxyDetail:
            return Data("""
                {
                  "isSuccess": true,
                  "code": "string",
                  "message": "string",
                  "result": {
                    "galaxyId": 0,
                    "name": "string",
                    "emojiResourceName": "string",
                    "dDay": 0,
                    "startDate": "2026-01-27",
                    "endDate": "2026-01-27",
                    "placeName": "string"
                  }
                }
                """.utf8)
        case .fetchGalaxyList:
            return Data("""
            {
              "isSuccess": true,
              "code": "string",
              "message": "string",
              "result": {
                "totalCount": 0,
                "galaxies": [
                  {
                    "galaxyId": 0,
                    "name": "string",
                    "emojiResourceName": "string"
                  }
                ],
                "currentPage": 0,
                "hasNext": true
              }
            }
           """.utf8)
        case .createGalaxy, .patchGalaxy, _:
            return Data()
        }
    }
}
