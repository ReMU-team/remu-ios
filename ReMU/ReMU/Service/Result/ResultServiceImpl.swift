//
//  ResultServiceImpl.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation
import Moya

final class ResultServiceImpl: ResultServiceProtocol {
    
    private let provider: MoyaProvider<ResultTargetType>
    
    init(provider: MoyaProvider<ResultTargetType>) {
        self.provider = provider
    }
    
    func createResult(
        userId: Int,
        galaxyId: Int,
        request: createResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        provider.request(
            .createResult(
                userId: userId,
                galaxyId: galaxyId,
                request: request
            )
        ) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func checkResult(
        userId: Int,
        galaxyId: Int,
        completion: @escaping (Result<CheckResultResponse, Error>) -> Void
    ) {
        provider.request(
            .checkResult(userId: userId, galaxyId: galaxyId)
        ) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(
                        CheckResultResponse.self,
                        from: response.data
                    )
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


    func patchResult(
        userId: Int,
        galaxyId: Int,
        request: patchResultRequest,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        provider.request(
            .patchResult(
                userId: userId,
                galaxyId: galaxyId,
                request: request
            )
        ) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }


}
