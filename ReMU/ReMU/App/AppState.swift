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

    @Published var route: AppRoute = .splash

    // 로그인 상태인지 체크하기
    func checkLoginStatus() async {
        
        // TODO: 나중에 Keychain / 토큰으로 교체
        let isLoggedIn = false

        // 스플래시 유지 시간
        try? await Task.sleep(nanoseconds: 2_500_000_000)

        await MainActor.run {
            self.route = isLoggedIn ? .main : .auth
        }
    }
}
