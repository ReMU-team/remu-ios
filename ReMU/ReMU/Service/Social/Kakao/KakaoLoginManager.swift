//
//  KakaoLoginManager.swift
//  ReMU
//
//  Created by 원서우 on 1/25/26.
//

import Foundation
import KakaoSDKUser

class KakaoManager {
    static let shared = KakaoManager()
    
    private init() {}
    
    
    func kakaoLogin(completion: @escaping (Bool) -> Void) {
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                }
            }
        }
        else {
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                if let error = error {
                    print(error)
                } else {
                    print("카카오계정 로그인 success")
                    
                    // 추가작업
                    _ = oauthToken
                }
            }
        }
    }
    
    func kakaoLogout() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    
    func kakaoUnlink() {
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("unlink() success.")
            }
        }
    }
    
    
    func getUserInfo() {
        UserApi.shared.me() {(user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("me() success.")
                
                //do something
                let userName = user?.kakaoAccount?.name
                let userEmail = user?.kakaoAccount?.email
                let userProfile = user?.kakaoAccount?.profile?.profileImageUrl
                
                print("이름: \(userName)")
                print("이메일: \(userEmail)")
                print("프로필: \(userProfile)")
            }
        }
    }
}
