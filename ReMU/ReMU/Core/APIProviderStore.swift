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
        return networkService.testProvider(for: UserTargetType.self)
    }
    /// 로그인 플로우 Provieder
    func auth() -> MoyaProvider<AuthTargetType> {
        return networkService.createUnauthenticatedProvider(for: AuthTargetType.self)
    }
    
    func galaxy() -> MoyaProvider<GalaxyTargetType> {
        return networkService.createProvider(for: GalaxyTargetType.self)
    }
}
