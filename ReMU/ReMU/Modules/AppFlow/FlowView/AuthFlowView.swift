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

    let onAuthFinished: () -> Void
    var body: some View {
        if showCreateProfile {
            CreateProfileView(
                onBack: {
                    // 온보딩으로 되돌림
                    showCreateProfile = false
                    showOnboarding = true
                },
                onFinish: {
                    onAuthFinished()
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
                onKakaoLogin: {
                        // Placeholder(<#...#>)가 남아있지 않도록 주의하세요!
                        KakaoManager.shared.kakaoLogin { success in
                            if success {
                                showOnboarding = true
                            }
                        }
                    },
                onGoogleLogin: { showOnboarding = true },
                onAppleLogin: { showOnboarding = true }
            )
        }
    }
}


