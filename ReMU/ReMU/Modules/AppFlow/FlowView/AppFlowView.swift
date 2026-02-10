//
//  AppFlowView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct AppFlowView: View {
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var container: DIContainer
    
    var body: some View {
        HomeGalaxyView(container: container)
            .environmentObject(appState)
//            .onAppear {
//                guard let galaxyId = appState.currentGalaxyId else { return }
//                NotificationScheduler.shared.evaluateTodayNotifications(galaxy: galaxy)
//            } // TODO: task 안정화
    }
}


#Preview {
    AppFlowView()
        .environmentObject(AppState())
}

