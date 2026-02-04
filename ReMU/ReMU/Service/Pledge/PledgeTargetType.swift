//
//  PledgeTargetType.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation
import Alamofire
import Moya

enum PledgeTargetType {
    case createPledge(galaxyId: Int,request: CreatePledgeRequest)
    case checkPledge(galaxyId: Int)
    case patchPledge(galaxyId: Int, request: PatchPledgeRequest)
}

extension PledgeTargetType: APITargetType{
    var path: String {
        switch self {
        case .createPledge(let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)/resolutions"
        case .checkPledge(let galaxyId):
            return "/api/v1/galaxies/\(galaxyId)/resolutions"
        case .patchPledge(let galaxyId,_):
            return "/api/v1/galaxies/\(galaxyId)/resolutions"
        }}
    var method: Moya.Method {
        switch self {
        case .createPledge:
            return .post
        case .checkPledge:
            return .get
        case .patchPledge:
            return .patch
        }}
    var task: Moya.Task {
        switch self{
        case .createPledge(_, let request):
            return .requestJSONEncodable(request)
        case .checkPledge:
            return .requestPlain
        case .patchPledge(_,let request):
            return .requestJSONEncodable(request)
        }
        
    }
}
