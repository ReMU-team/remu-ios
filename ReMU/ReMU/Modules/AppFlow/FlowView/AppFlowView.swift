//
//  AppFlowView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct AppFlowView: View {
    @StateObject private var appState = AppState()
    
    var body: some View {
        switch appState.homeState {
                case .empty:
                    HomeView()
                        .environmentObject(appState)

                case .galaxy:
                    HomeGalaxyView()
                        .environmentObject(appState)
                }
    }
}

// 홈 상태 비어있을 때 / 은하 있을 때
enum HomeState {
    case empty
    case galaxy
}




#Preview {
    AppFlowView()
}
