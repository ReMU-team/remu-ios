//
//  AuthFlowView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct AuthFlowView: View {
    @State private var showOnboarding = false
    @State private var showCreateProfile = false
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn { // 로그인 상태일 때는 바로 메인화면으로 이동
            AppFlowView()
        } else if showCreateProfile {
            CreateProfileView(
                onBack: {
                    // 온보딩으로 되돌림
                    showCreateProfile = false
                    showOnboarding = true
                },
                onFinish: {
                    isLoggedIn = true
                }
            )
        } else if showOnboarding {
            OnboardingView(
                onExit: { showOnboarding = false },
                onFinish: {
                    showOnboarding = false
                    showCreateProfile = true
                }
            )
        } else {
            LoginView(
                onKakaoLogin: { showOnboarding = true },
                onGoogleLogin: { showOnboarding = true },
                onAppleLogin: { showOnboarding = true }
            )
        }
    }
}



