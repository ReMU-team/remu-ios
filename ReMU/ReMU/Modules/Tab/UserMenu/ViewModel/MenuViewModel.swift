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
    private let tokenProvider: TokenProviding

    init(
        provider: MoyaProvider<UserTargetType>,
        tokenProvider: TokenProviding
    ) {
        self.provider = provider
        self.tokenProvider = tokenProvider
    }

    // MARK: - 프로필 조회 API
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
            
            profile = UserProfile(
                name: result.name,
                introduction: result.introduction,
                imageUrl: result.imageUrl
            )
        } catch {
            hasError = true
        }
        
        isLoading = false
    }
    
    // MARK: - 탈퇴하기 API (계정 삭제)
    func deleteAccount(appState: AppState) async {
        do {
            let response = try await provider.requestAsync(.deleteUser)
            let decoded = try response.map(BaseResponse<String>.self)

            guard decoded.isSuccess else {
                AlertManager.shared.showError(message: decoded.message)
                return
            }

            AlertManager.shared.show(.confirmDelete {
                self.tokenProvider.clearSession()
                appState.route = .auth
            })

        } catch {
            AlertManager.shared.showError(message: "탈퇴에 실패했어요.")
        }
    }

}


