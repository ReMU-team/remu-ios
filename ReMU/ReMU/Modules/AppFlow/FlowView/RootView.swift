//
//  RootView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()
    @StateObject private var container: DIContainer = .init()

    
    var body: some View {
        switch appState.route {
        case .splash:
            SplashView()
                .onAppear {
                    Task {
                        await appState.checkLoginStatus(
                            keychain: container.userSessionKeychain
                        )
                    }
                }
            
        case .auth:
            AuthFlowView {
                appState.route = .main // 인증/온보딩 끝
            }
            .environmentObject(appState)
            
        case .main:
            AppFlowView()
                .environmentObject(appState)
            
        }
    }
}



#Preview {
    RootView()
}
