//
//  ReMUApp.swift
//  ReMU
//
//  Created by 김진서 on 1/9/26.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth


@main
struct ReMUApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var container: DIContainer = .init()
    @StateObject private var appState = AppState()
    
    init() {
            // kakao sdk 초기화
            let kakaoNativeAppKey = (Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String) ?? ""
            KakaoSDK.initSDK(appKey: kakaoNativeAppKey)
            print("카카오 키: \(kakaoNativeAppKey)")
        }
    
    var body: some Scene {
        WindowGroup {
            RootView() // 앱 시작 진입점
                .onOpenURL(perform: { url in
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                })
                .environmentObject(container)
                .environmentObject(appState)
        }
    }
}
