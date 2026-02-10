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
    @Published var currentGalaxy: Galaxy?

    @MainActor
    func checkLoginStatus(keychain: UserSessionKeychainService) async {

        try? await Task.sleep(nanoseconds: 2_500_000_000)

        let session = keychain.loadSession(for: .userSession)

        self.route = session == nil ? .auth : .main
    }
}
