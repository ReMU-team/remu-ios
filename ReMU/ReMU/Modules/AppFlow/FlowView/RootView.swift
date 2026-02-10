//
//  RootView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject private var appState: AppState
    @EnvironmentObject private var container: DIContainer

    
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
            
        case .main:
            AppFlowView()
            
        }
    }
}



#Preview {
    RootView()
}
