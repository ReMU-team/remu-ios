//
//  PledgeService.swift
//  ReMU
//
//  Created by 원서우 on 2/12/26.
//

import Foundation
import Moya

// 1. 프로토콜 정의 (ViewModel이 쓸 기능)
protocol PledgeServiceProtocol {
    func getPledge(galaxyId: Int, completion: @escaping (Result<CheckPledgeResponse, Error>) -> Void)
}

// 2. 구현체 정의
final class PledgeServiceImpl: PledgeServiceProtocol {
    private let provider: MoyaProvider<PledgeTargetType>

    init(provider: MoyaProvider<PledgeTargetType>) {
        self.provider = provider
    }

    func getPledge(galaxyId: Int, completion: @escaping (Result<CheckPledgeResponse, Error>) -> Void) {
        provider.request(.checkPledge(galaxyId: galaxyId)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(CheckPledgeResponse.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
