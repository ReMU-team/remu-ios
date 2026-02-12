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
    case createStar(
        accessToken: String,
        request: CreateStarRequest,
        image: Data?,            // optional
        fileName: String?,
        mimeType: String?
    )
    case fetchStarsList(accessToken: String, galaxyId: Int)
    case fetchStarDetail(accessToken: String, starId: Int)
    case patchStar(
        accessToken: String,
        request: PatchStarRequest,
        starId: Int,
        image: Data?,
        fileName: String?,
        mimeType: String?
    )
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
        case .patchStar(_,_,let starId,_,_,_):
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
        case .createStar(let accessToken,_,_,_,_),
                .fetchStarsList(let accessToken,_),
                .fetchStarDetail(let accessToken,_),
                .patchStar(let accessToken,_,_,_,_,_),
                .deleteStar(accessToken: let accessToken, starId: _):
            var header = ["Accept": "application/json"]
            header["Authorization"] = "Bearer \(accessToken)"
            return header
        }
    }
    // TODO: 수정 필요
    var task: Moya.Task {
        switch self{
        case let .createStar(_, request, image, fileName, mimeType):
            guard let json = try? JSONEncoder().encode(request) else {
                return .requestPlain
            }
            var parts: [Moya.MultipartFormData] = [
                .init(
                    provider: .data(json),
                    name: "request",
                    fileName: "request.json",
                    mimeType: "application/json"
                )
            ]
            if let image, let fileName, let mimeType {
                parts.append(
                    .init(
                        provider: .data(image),
                        name: "image",
                        fileName: fileName,
                        mimeType: mimeType
                    )
                )
            }
            return .uploadMultipart(parts)
            
        case let .patchStar(_, request, _, image, fileName, mimeType):
            guard let json = try? JSONEncoder().encode(request) else {
                return .requestPlain
            }
            var parts: [Moya.MultipartFormData] = [
                .init(provider: .data(json),
                      name: MultipartField.request,
                      fileName: "request.json",
                      mimeType: "application/json")
            ]
            if let image,
               let fileName,
               let mimeType {
                parts.append(
                    .init(
                        provider: .data(image),
                        name: "image",
                        fileName: fileName,
                        mimeType: mimeType
                    )
                )
            }
            
            return .uploadMultipart(parts)
            
        case .fetchStarsList, .fetchStarDetail, .deleteStar:
            return .requestPlain
        }
    }
    
    var sampleData: Data{
        return Data("""
            {
            "isSuccess": true,
            "code": "STAR200_2",
            "message": "별 상세 정보를 성공적으로 조회했습니다.",
            "result": {
            "starId": 1,
            "title": "우도 구경",
            "content": "땅콩 아이스크림 먹음. 날씨 좋았다.",
            "recordDate": "2024-05-21",
            "dDay": 2,
            "imageUrl": "[https://dummy-s3-url.com/image.jpg](https://dummy-s3-url.com/image.jpg)",
            "cardColor": "PURPLE",
            "emojis": ["icecream", "peanut"]
            }
            }
            """.utf8)
    }
}
