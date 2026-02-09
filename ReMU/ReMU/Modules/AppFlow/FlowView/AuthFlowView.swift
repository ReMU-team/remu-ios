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
    @State private var showProfileIntro = false
    
    @EnvironmentObject var appState: AppState
    
    @StateObject private var profileViewModel: ProfileViewModel
    
    let onAuthFinished: () -> Void
    
    init(onAuthFinished: @escaping () -> Void) {
            self.onAuthFinished = onAuthFinished

            _profileViewModel = StateObject(
                wrappedValue: ProfileViewModel(
                    networkService: NetworkServiceImpl(
                        userSessionKeychain: UserSessionKeychainServiceImpl()
                    ),
                    appState: AppState()
                )
            )
        }
    
    var body: some View {
        if showCreateProfile {
                    CreateProfileView(
                        viewModel: profileViewModel,
                        onBack: {
                            showCreateProfile = false
                            showOnboarding = true
                        },
                        onFinish: {
                            onAuthFinished()
                        }
                    )
                }
        else if showOnboarding {
            OnboardingView(
                onExit: { showOnboarding = false },
                onFinish: {
                    showOnboarding = false
                    showProfileIntro = true
                }
            )
        } else if showProfileIntro {
            ProfileIntroView()
                .transition(.opacity)
                .onAppear {
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        withAnimation {
                            showProfileIntro = false
                            showCreateProfile = true
                        }
                    }
                }
            
        } else {
            LoginView(
                onKakaoLogin: {
                    // Placeholder(<#...#>)가 남아있지 않도록 주의하세요!
                    KakaoManager.shared.kakaoLogin { success in
                        if (success != nil) {
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


