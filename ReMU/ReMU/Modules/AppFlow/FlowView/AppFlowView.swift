//
//  AppFlowView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct AppFlowView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        HomeGalaxyView()
            .environmentObject(appState)
            .environmentObject(appState.profileViewModel)
    }
}

#Preview {
    AppFlowView()
}
