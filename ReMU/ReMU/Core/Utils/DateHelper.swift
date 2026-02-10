//
//  DateHelper.swift
//  ReMU
//
//  Created by 김진서 on 1/11/26.
//

import Foundation

// 날짜 표시용 텍스트 helper
extension Date {
    /// 날짜 UI 변환 (yy.MM.dd)
    var uiFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: self)
    }
    
    /// 날짜 선택시 시간 제외 날짜만 고려
    var dayOnly: Date {
        Calendar.current.startOfDay(for: self)
    }
    
    /// 서버 전송용 (yyyy-MM-dd)
        var serverFormat: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale(identifier: "ko_KR")
            formatter.timeZone = .current
            return formatter.string(from: self)
        }
    
    /// 여행 n일차 계산 (Day 1부터 시작)
        static func travelDay(from startDate: Date) -> Int {
            let calendar = Calendar.current
            let start = calendar.startOfDay(for: startDate)
            let today = calendar.startOfDay(for: Date())

            let diff = calendar.dateComponents([.day], from: start, to: today).day ?? 0
            return diff + 1
        }
}

extension String {
    /// 서버 날짜 문자열 (yyyy-MM-dd) -> Date
    var toDateFromServer: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = .current
        return formatter.date(from: self)
    }
}



// 날짜 범위 표시 텍스트
func dateRangeText(start: Date?, end: Date?) -> String? {
    guard let start, let end else { return nil }
    return "\(start.uiFormat) ~ \(end.uiFormat)"
}

// 기록 카드에서 쓰이는 여행 기간 UI
func travelPeriodText(start: Date, end: Date) -> String {
    "\(start.serverFormat)-\(end.serverFormat)"
}
