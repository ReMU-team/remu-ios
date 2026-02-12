//
//  LoginView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI
    
struct LoginView: View {
    
    @StateObject private var viewModel: LoginViewModel
    
    let onAuthFinished: (_ isNewUser: Bool) -> Void
    
    init(
        container: DIContainer,
        onAuthFinished: @escaping (_ isNewUser: Bool) -> Void
    ) {
        _viewModel = StateObject(
            wrappedValue: LoginViewModel(container: container)
        )
        self.onAuthFinished = onAuthFinished
    }
    
    
    // MARK: - body
    var body: some View {
        logo
            .padding(.top, 100)
        Spacer()
        login
            .padding(.bottom, 92)
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
                .padding(.bottom, 16)
            
            // 로그인 버튼
            VStack (spacing: 20){
                SocialLoginButton(type: .kakao) {
                    Task {
                        await viewModel.kakaoLogin { isNewUser in
                            onAuthFinished(isNewUser)
                        }
                    }
                }
                SocialLoginButton(type: .google) {
                    print("구글 로그인 예정")
                }
                SocialLoginButton(type: .apple) {
                    print("애플 로그인 예정")
                }
            }
        }
        .padding(.horizontal, 46)
    }
}

#Preview {
    LoginView(
        container: .preview,
        onAuthFinished: { isNewUser in
            print("Preview login success", isNewUser)
        }
    )
}
