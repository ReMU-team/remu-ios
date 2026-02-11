//
//  FeedbackTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation
import Alamofire
import Moya

enum FeedbackTargetType {
    case createFeedback(galaxyId: Int)
    case fetchFeedback(galaxyId: Int)
    case patchFeedback(galaxyId: Int)
}

extension FeedbackTargetType: APITargetType {

    var path: String {
        switch self {
        case .createFeedback(let galaxyId),
             .fetchFeedback(let galaxyId),
             .patchFeedback(let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/feedback"
        }
    }

    var method: Moya.Method {
        switch self {
        case .createFeedback:
            return .post
        case .fetchFeedback:
            return .get
        case .patchFeedback:
            return .patch
        }
    }

    /// Authorization은 Network / APITargetType 공통 처리
    var headers: [String : String]? {
        ["Accept": "application/json"]
    }

    var task: Moya.Task {
        .requestPlain
    }
}
