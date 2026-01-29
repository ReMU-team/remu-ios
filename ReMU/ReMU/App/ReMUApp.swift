//
//  ReMUApp.swift
//  ReMU
//
//  Created by 김진서 on 1/9/26.
//

import SwiftUI

@main
struct ReMUApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var container: DIContainer = .init()
    
    var body: some Scene {
        WindowGroup {
            RootView() // 앱 시작 진입점
                //.environmentObject(container)
            
        }
    }
}
