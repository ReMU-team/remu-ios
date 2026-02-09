//
//  UserService.swift
//  ReMU
//
//  Created by 원서우 on 1/25/26.
//

import Foundation
import Moya

final class UserService {

    private let provider: MoyaProvider<UserTargetType>

    init(networkService: NetworkService) {
        self.provider = networkService.createProvider(for: UserTargetType.self)
    }

    func createProfile(
        request: PatchUserRequest,
        completion: @escaping (Bool) -> Void
    ) {
        provider.request(.patchUser(request: request)) { result in
            switch result {
            case .success(let response):
                let decoded = try? response.map(BaseResponse<EmptyResponse>.self)
                completion(decoded?.isSuccess == true)

            case .failure:
                completion(false)
            }
        }
    }
}
