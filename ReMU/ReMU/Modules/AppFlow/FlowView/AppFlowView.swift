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
            .onAppear {
                guard let galaxy = appState.currentGalaxy else { return }
                NotificationScheduler.shared.evaluateTodayNotifications(galaxy)
            } // TODO: task 안정화
    }
}


#Preview {
    AppFlowView()
}
