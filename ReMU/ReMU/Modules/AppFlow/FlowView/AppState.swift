//
//  AppState.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    
    enum AppRoute {
        case splash
        case auth
        case main
    }
    @Published var userProfile: UserProfile? = nil
    @Published var route: AppRoute = .splash
    @Published var currentGalaxyId: Int?
    
    @MainActor
    func checkLoginStatus(keychain: UserSessionKeychainService) async {

        let hasSession = keychain.loadSession(for: .userSession) != nil

        try? await Task.sleep(nanoseconds: 2_500_000_000)

        await MainActor.run {
            if hasSession {
                self.enterMain()
            } else {
                self.route = .auth
            }
        }
    }

    
    func enterMain() {
        route = .main
    }

}
