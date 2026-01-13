//
//  AppRouteEnum.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import Foundation
import Combine

enum AppRoute {
    case splash
    case auth
    case main
}

final class AppState: ObservableObject {
    @Published var route: AppRoute = .splash

    func checkLoginStatus() async {
        // TODO: 나중에 Keychain / 토큰으로 교체
        let isLoggedIn = false

        try? await Task.sleep(nanoseconds: 2_500_000_000)

        await MainActor.run {
            self.route = isLoggedIn ? .main : .auth
        }
    }
}
