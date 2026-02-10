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
        userId: Int,
        galaxyId: Int,
        request: createResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    )

    func checkResult(
        userId: Int,
        galaxyId: Int,
        completion: @escaping (Result<CheckResultResponse, Error>) -> Void
    )

    func patchResult(
        userId: Int,
        galaxyId: Int,
        request: patchResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}


