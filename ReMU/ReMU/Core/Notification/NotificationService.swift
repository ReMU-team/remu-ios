//
//  NotificationService.swift
//  ReMU
//
//  Created by 원서우 on 2/7/26.
//

import Foundation
import UserNotifications

final class NotificationService {

    static let shared = NotificationService()
    private init() {}

    // MARK: - 공통 add 함수
    private func addNotification(
        identifier: String,
        title: String,
        body: String,
        triggerDate: Date
    ) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: Calendar.current.dateComponents(
                [.year, .month, .day, .hour, .minute],
                from: triggerDate
            ),
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: identifier,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request)
    }
}

// MARK: - 여행 시작 알림 (09:00)
extension NotificationService {

    func sendTravelStart(at date: Date, identifier: String) {
        addNotification(
            identifier: identifier,
            title: "여행 시작 ✈️",
            body: "드디어 여행 날이에요! 즐거운 여행 되세요 ✈️",
            triggerDate: date
        )
    }
}

// MARK: - 기록 유도 알림 (23:00)
extension NotificationService {

    func sendRecordReminder(
        isFirstDay: Bool,
        at date: Date,
        identifier: String
    ) {
        let body = isFirstDay
        ? "여행지에 잘 도착하셨나요? 첫 기록을 남겨보세요! 📝"
        : "오늘 하루는 어떠셨나요? 기록을 남겨보세요.📝"

        addNotification(
            identifier: identifier,
            title: "오늘의 기록 ✍️",
            body: body,
            triggerDate: date
        )
    }
}

// MARK: - 랜덤 질문 알림 (14:00 / 20:00)
extension NotificationService {

    func sendRandomQuestion(
        question: String,
        at date: Date,
        identifier: String
    ) {
        addNotification(
            identifier: identifier,
            title: "오늘의 질문 💭",
            body: question,
            triggerDate: date
        )
    }
}

// MARK: - 회고 알림 (여행 종료 다음날 10:00)
extension NotificationService {

    func sendReviewReminder(
        at date: Date,
        identifier: String
    ) {
        addNotification(
            identifier: identifier,
            title: "여행 회고 📚",
            body: "여행은 즐거우셨나요? 여행의 추억을 정리해보세요 📚",
            triggerDate: date
        )
    }
}

// MARK: - 권한 요청
extension NotificationService {
    func requestPermission() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current()
            .requestAuthorization(options: options) { _, _ in }
    }
}

