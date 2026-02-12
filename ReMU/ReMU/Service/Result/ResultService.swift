//
//  ResultService.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation
import Moya

protocol ResultServiceProtocol {
    func createResult(
        galaxyId: Int,
        request: createResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    )

    func checkResult(
        galaxyId: Int,
        completion: @escaping (Result<CheckResultResponse, Error>) -> Void
    )

    func patchResult(
        galaxyId: Int,
        request: patchResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    )
    
}


