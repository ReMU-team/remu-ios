//
//  AppDelegate.swift
//  ReMU
//
//  Created by 원서우 on 1/11/26.
//

import Foundation
import UIKit
import UserNotifications

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 앱이 실행될 때 델리게이트 위임
        UNUserNotificationCenter.current().delegate = self
        // (선택) 앱 켜자마자 권한 요청하고 싶으면 여기서 호출
         NotificationService.shared.requestPermission()
        
        return true
    }
}

// 앱 실행 중(Foreground)일 때 알림 처리
extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 배너, 소리, 배지 모두 표시하겠다고 설정
        completionHandler([.banner, .list, .sound, .badge])
    }
}
