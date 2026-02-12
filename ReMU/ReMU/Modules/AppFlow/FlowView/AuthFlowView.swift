//
//  AuthFlowView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct AuthFlowView: View {
    @EnvironmentObject private var container: DIContainer
    
    @State private var showOnboarding = false
    @State private var showCreateProfile = false
    @State private var showProfileIntro = false
    
    
    let onAuthFinished: () -> Void
    
    var body: some View {
        if showCreateProfile {
            CreateProfileView(
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
                container: container,
                onAuthFinished: { isNewUser in
                    if isNewUser {
                        showOnboarding = true
                    } else {
                        onAuthFinished()
                    }
                }
            )
        }
    }
}


#Preview {
    AuthFlowView(
        onAuthFinished: {
            print("Auth Finished")
        }
    )
    .environmentObject(DIContainer.preview)
}


