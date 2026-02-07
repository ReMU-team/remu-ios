//
//  NotificationScheduler.swift
//  ReMU
//
//  Created by 원서우 on 2/7/26.
//

import Foundation

import UserNotifications

final class NotificationScheduler {

    static let shared = NotificationScheduler()
    private init() {}

    // MARK: - Public Entry
    /// 앱 실행 / 포그라운드 진입 / 여행 데이터 갱신 시 호출
    func evaluateTodayNotifications(galaxy: Galaxy) {
        let today = Date()
        
        scheduleTravelStartIfNeeded(galaxy: galaxy, today: today)
        scheduleRecordReminderIfNeeded(galaxy: galaxy, today: today)
        scheduleRandomQuestionIfNeeded(galaxy: galaxy, today: today, hour: 14)
        scheduleRandomQuestionIfNeeded(galaxy: galaxy, today: today, hour: 20)
        scheduleReviewReminderIfNeeded(galaxy: galaxy, today: today)
    }
}

// MARK: - 날짜 계산 유틸 (dayOffset 핵심)
private extension NotificationScheduler {

    func dayOffset(from startDate: Date, to date: Date) -> Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let target = calendar.startOfDay(for: date)
        let diff = calendar.dateComponents([.day], from: start, to: target).day ?? 0
        return diff + 1 // DAY1부터 시작
    }

    func isTravelOngoing(galaxy: Galaxy, today: Date) -> Bool {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: today)
        return todayStart >= calendar.startOfDay(for: galaxy.startDate)
            && todayStart <= calendar.startOfDay(for: galaxy.endDate)
    }

    func todayStarCount(galaxy: Galaxy, today: Date) -> Int {
        let offset = dayOffset(from: galaxy.startDate, to: today)
        return galaxy.stars.filter { $0.dayOffset == offset }.count
    }
}

// MARK: - 여행 시작 알림 (09:00)
private extension NotificationScheduler {

    func scheduleTravelStartIfNeeded(galaxy: Galaxy, today: Date) {
        let calendar = Calendar.current
        let todayStart = calendar.startOfDay(for: today)
        let startDay = calendar.startOfDay(for: galaxy.startDate)

        let identifier = "travel_start_\(dateKey(today))"

        guard todayStart == startDay else {
            cancel(identifier)
            return
        }

        NotificationService.shared.sendTravelStart(
            at: dateWith(hour: 9, minute: 0, base: today),
            identifier: identifier
        )
    }
}

// MARK: - 기록 유도 알림 (23:00)
private extension NotificationScheduler {

    func scheduleRecordReminderIfNeeded(galaxy: Galaxy, today: Date) {
        let identifier = "record_reminder_\(dateKey(today))"

        guard isTravelOngoing(galaxy: galaxy, today: today) else {
            cancel(identifier)
            return
        }

        let starCount = todayStarCount(galaxy: galaxy, today: today)
        guard starCount == 0 else {
            cancel(identifier)
            return
        }

        let isFirstDay = Calendar.current.isDate(today, inSameDayAs: galaxy.startDate)

        NotificationService.shared.sendRecordReminder(
            isFirstDay: isFirstDay,
            at: dateWith(hour: 23, minute: 0, base: today),
            identifier: identifier
        )
    }
}

// MARK: - 랜덤 질문 알림 (14:00 / 20:00)
private extension NotificationScheduler {

    func scheduleRandomQuestionIfNeeded(
        galaxy: Galaxy,
        today: Date,
        hour: Int
    ) {
        let identifier = "random_question_\(hour)_\(dateKey(today))"

        guard isTravelOngoing(galaxy: galaxy, today: today) else {
            cancel(identifier)
            return
        }

        let starCount = todayStarCount(galaxy: galaxy, today: today)

        let intent: QuestionIntent = starCount == 0 ? .easy : .deep
        let question = QuestionProvider.randomQuestion(intent: intent)

        NotificationService.shared.sendRandomQuestion(
            question: question,
            at: dateWith(hour: hour, minute: 0, base: today),
            identifier: identifier
        )
    }
}


// MARK: - 회고 알림 (여행 종료 + 1일 10:00)
private extension NotificationScheduler {

    func scheduleReviewReminderIfNeeded(galaxy: Galaxy, today: Date) {
        let calendar = Calendar.current
        guard let reviewDay = calendar.date(byAdding: .day, value: 1, to: galaxy.endDate) else { return }

        let identifier = "review_reminder_\(galaxy.serverId)"

        if calendar.isDate(today, inSameDayAs: reviewDay) {
            NotificationService.shared.sendReviewReminder(
                at: dateWith(hour: 10, minute: 0, base: today),
                identifier: identifier
            )
        } else {
            cancel(identifier)
        }
    }
}

// MARK: - 공통 유틸 (날짜 & cancel)
private extension NotificationScheduler {

    func dateWith(hour: Int, minute: Int, base: Date) -> Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: base)
        components.hour = hour
        components.minute = minute
        return calendar.date(from: components) ?? base
    }

    func dateKey(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: date)
    }

    func cancel(_ identifier: String) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
