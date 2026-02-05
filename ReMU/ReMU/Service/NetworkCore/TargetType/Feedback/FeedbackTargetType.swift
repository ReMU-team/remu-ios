//
//  FeedbackTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation
import Alamofire
import Moya

enum FeedbackTargetType{
    case createFeedback(accessToken: String, galaxyId: Int)
    case fetchFeedback(accessToken: String, galaxyId: Int)
    case patchFeedback(accessToken: String, galaxyId: Int)
}

extension FeedbackTargetType: APITargetType{
    var path: String {
        switch self {
        case .createFeedback(_,let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/feedback"
        case .fetchFeedback(_,let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/feedback"
        case .patchFeedback(_,let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/feedback"
        }
    }
    var method: Moya.Method{
        switch self{
        case .createFeedback:
            return .post
        case .fetchFeedback:
            return .get
        case .patchFeedback:
            return .patch
        }
    }
    var headers: [String : String]?{
        switch self {
        case .createFeedback(let accessToken,_),.fetchFeedback(let accessToken,_),.patchFeedback(let accessToken,_):
            var header = ["Accept": "application/json"]
            header["Authorization"] = "Bearer \(accessToken)"
            return header
        }
    }
    
    var task: Moya.Task{
        return .requestPlain
        }
    }

