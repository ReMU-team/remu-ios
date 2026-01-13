//
//  RootView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct RootView: View {
    @StateObject private var appState = AppState()

    var body: some View {
        switch appState.route {
        case .splash:
            SplashView()
                .task {
                    await appState.checkLoginStatus()
                }

        case .auth:
            AuthFlowView {
                appState.route = .main
            }

        case .main:
            AppFlowView()
        }
    }
}



#Preview {
    RootView()
}
