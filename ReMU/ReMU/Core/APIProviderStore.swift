//
//  APIProviderStore.swift
//  ReMU
//
//  Created by 김종수 on 2/3/26.
//

import Foundation
import Moya

final class APIProviderStore {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension APIProviderStore {
    func user() -> MoyaProvider<UserTargetType> {
        return networkService.createProvider(for: UserTargetType.self)
    }
    /// 로그인 플로우 Provieder
    func auth() -> MoyaProvider<AuthTargetType> {
        return networkService.createProvider(for: AuthTargetType.self)
    }

    func galaxy() -> MoyaProvider<GalaxyTargetType> {
        return networkService.createProvider(for: GalaxyTargetType.self)
    }
    func star() -> MoyaProvider<StarTargetType> {
        return networkService.createProvider(for: StarTargetType.self)
    }
    func feedback() -> MoyaProvider<FeedbackTargetType> {
        return networkService.createProvider(for: FeedbackTargetType.self)
    }
    func pledge() -> MoyaProvider<PledgeTargetType> {
        return networkService.createProvider(for: PledgeTargetType.self)
    }
    func result() -> MoyaProvider<ResultTargetType> {
        return networkService.createProvider(for: ResultTargetType.self)
    }
}
