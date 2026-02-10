//
//  LoginViewModel.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation
import Combine
import Moya

// MARK:
// 소셜 로그인으로 액세스 및 리프레쉬 토큰만 받아옴
final class LoginViewModel: ObservableObject {
    // MARK: - Property
    
    private let loginProvider: MoyaProvider<AuthTargetType>
    private let keychain: UserSessionKeychainService
    private let kakaoLoginManager: KakaoManager
    
    //let provider: String
    
    // MARK: - Init
    init(container: DIContainer,
         kakaoLoginManager: KakaoManager = .shared
    ) {
        self.loginProvider = container.apiProviderStore.auth()
        self.keychain = container.userSessionKeychain
        self.kakaoLoginManager = kakaoLoginManager
        
    }
    
    // MARK: - Func
    @MainActor
    func kakaoLogin(onSuccess: @escaping () -> Void) async {
        kakaoLoginManager.kakaoLogin { [weak self] tokens in
            guard
                let self = self,
                let kakaoAccessToken = tokens?.accessToken
            else {
                print("❌ 카카오 accessToken 없음")
                return
            }

            self.loginProvider.request(
                .socialLogin(provider: "kakao", token: kakaoAccessToken)
            ) { result in
                switch result {
                case .success(let response):
                    guard
                        let tokenResponse = try? JSONDecoder().decode(
                            TokenResponse.self,
                            from: response.data
                        )
                    else {
                        print("❌ 토큰 응답 디코딩 실패")
                        return
                    }
                    
                    let session = UserInfo(
                        accessToken: tokenResponse.result.accessToken,
                        refreshToken: tokenResponse.result.refreshToken
                    )
                    
                    let saved = self.keychain.saveSession(
                        session,
                        for: .userSession
                    )
                    
                    print(saved ? "✅ 세션 저장 성공" : "❌ 세션 저장 실패")
                    onSuccess()
                    
                case .failure(let error):
                    print("❌ 서버 로그인 실패", error)
                }
            }
        }
    }

}
