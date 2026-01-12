//
//  NotificationService.swift
//  ReMU
//
//  Created by 원서우 on 1/11/26.
//

import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()
    
    private init() {}
    
    // 1. 권한 요청 함수
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("권한 요청 에러: \(error.localizedDescription)")
            } else {
                print("알림 권한 허용 여부: \(granted)")
            }
        }
    }
    
    // 2. 알림 보내기 함수 (여행지 도착)
    func sendArrivalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "여행지에 도착했어요!"
        content.body = "도착을 축하드려요! 이 순간의 설렘을 남겨보세요!"
        content.sound = .default
        
        // 테스트를 위해 3초 뒤 발송
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
}
