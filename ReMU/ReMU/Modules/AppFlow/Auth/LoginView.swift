//
//  LoginView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

    
struct LoginView: View {
    let onKakaoLogin: () -> Void
    let onGoogleLogin: () -> Void
    let onAppleLogin: () -> Void
    
    // MARK: - body
    var body: some View {
        logo
        login
    }
    
    // MARK: - logo section
    private var logo: some View {
        VStack{
            Image("logo_primary")
                .resizable()
                .frame(width: 146, height: 146)
            Image("logo_text")
                .padding(.top, 16)
                .padding(.bottom, 12)
            Text("여행의 시작, 당신만의 은하로 떠나요")
                .font(.pt13)
                .foregroundStyle(.grayScale7)
        }
        
    }
    
    // MARK: - login section
    private var login: some View {
        
        VStack {
            Text("소셜 계정으로 로그인")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
                .padding(.top, 142)
                .padding(.bottom, 16)
            
            // 로그인 버튼
            VStack (spacing: 20){
                SocialLoginButton(type: .kakao, action: onKakaoLogin)
                SocialLoginButton(type: .google, action: onGoogleLogin)
                SocialLoginButton(type: .apple, action: onAppleLogin)
            }
        }
        .padding(.horizontal, 46)
    }
    
   
}

#Preview {
    LoginView(
        onKakaoLogin: { print("kakao") },
        onGoogleLogin: { print("google") },
        onAppleLogin: { print("apple") }
    )
}

