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
    
    var body: some Scene {
        WindowGroup {
            //RootView()
            //ComponentExample()
            //CreateProfileView()
            WritePledgeView()
        }
    }
}
