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
        //        switch appState.homeState {
        //                case .empty:
        //                    HomeView()
        //                        .environmentObject(appState)
        //
        //                case .galaxy:
        //                    HomeGalaxyView()
        //                        .environmentObject(appState)
        //                }
        
        HomeGalaxyView()
            .environmentObject(appState)
        
    }
}

#Preview {
    AppFlowView()
}
