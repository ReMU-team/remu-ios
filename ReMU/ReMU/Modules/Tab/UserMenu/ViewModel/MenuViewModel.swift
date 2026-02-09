//
//  MenuViewModel.swift
//  ReMU
//
//  Created by 김진서 on 2/9/26.
//

import Foundation
import Combine
import Moya

@MainActor
final class MenuViewModel: ObservableObject {

    @Published var profile: UserProfile?
    @Published var isLoading = false
    @Published var hasError = false

    private let provider: MoyaProvider<UserTargetType>

    init(networkService: NetworkService) {
        self.provider = networkService.createProvider(for: UserTargetType.self)
    }

    func fetchProfile() async {
        isLoading = true
        hasError = false

        do {
            let response = try await provider.requestAsync(.checkUserProfile)
            let decoded = try response.map(BaseResponse<UserProfileResponse>.self)

            guard let result = decoded.result else {
                hasError = true
                return
            }

            self.profile = UserProfile(
                name: result.name,
                introduction: result.introduction,
                imageUrl: result.imageUrl
            )
        } catch {
            hasError = true
        }

        isLoading = false
    }
}


