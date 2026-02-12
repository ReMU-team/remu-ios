//
//  KakaoLoginManager.swift
//  ReMU
//
//  Created by 원서우 on 1/25/26.
//

import Foundation
import KakaoSDKUser
import KakaoSDKAuth



class KakaoManager {
    static let shared = KakaoManager()
    
    struct KakaoToken {
        let accessToken: String?
        let refreshToken: String?
    }
    
    private init() {}
    
    // 로그인 성공 시 accessToken 반환
    func kakaoLogin(completion: @escaping (KakaoToken?) -> Void) {
        
        let handleResult: (OAuthToken?, Error?) -> Void = { oauthToken, error in
            if let error = error {
                print(error)
                completion(nil)
            }
            else {
                print("로그인 success")
                print(oauthToken?.accessToken as Any)
                print(oauthToken?.refreshToken as Any)
                let tokens = KakaoToken(
                    accessToken: oauthToken?.accessToken, refreshToken: oauthToken?.refreshToken)
                completion(tokens)
            }
        }
        // 카카오톡 실행 가능 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인
            UserApi.shared.loginWithKakaoTalk(completion: handleResult)
        }else{
            // 카카오계정 로그인
            UserApi.shared.loginWithKakaoAccount(completion: handleResult)
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
