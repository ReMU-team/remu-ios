//
//  LoginViewModel.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation
import Moya

// MARK:
// 소셜 로그인으로 액세스 및 리프레쉬 토큰만 받아옴
@Observable
class LoginViewModel {
    // MARK: - Property
    
    private let LoginProvider: MoyaProvider<AuthTargetType>
    private let keychain: UserSessionKeychainService
    private let container: DIContainer
    private let kakaoLoginManager: KakaoManager
    
    // MARK: - Init
    init(container: DIContainer, kakaoLoginManager: KakaoManager = .shared){
        self.container = container
        self.LoginProvider = container.apiProviderStore.auth()
        self.keychain = container.userSessionKeychain
        self.kakaoLoginManager = kakaoLoginManager
    }
    
    // MARK: - Func
    @MainActor
    func kakaoLogin() async {
        do {
            kakaoLoginManager.kakaoLogin { [weak self] tokens in
                guard let self = self, let tokens = tokens else {
                    print("토큰을 받아오지 못했습니다.")
                    return
                }
            }
        }
    }
}
