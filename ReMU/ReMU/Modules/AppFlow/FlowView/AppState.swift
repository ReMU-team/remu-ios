//
//  AppState.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import Foundation
import Combine

final class AppState: ObservableObject {
    // 홈 상태 처리
    @Published var homeState: HomeState = .empty
    @Published var currentGalaxy: Galaxy?
    
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
