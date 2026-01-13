//
//  DateHelper.swift
//  ReMU
//
//  Created by 김진서 on 1/11/26.
//

import Foundation

// 날짜 표시용 텍스트 helper
extension Date {
    // 날짜 UI 변환
    var uiFormat: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter.string(from: self)
    }
    
    // 날짜 선택시 시간 제외 날짜만 고려
    var dayOnly: Date {
        Calendar.current.startOfDay(for: self)
    }
}




// 날짜 범위 표시 텍스트
func dateRangeText(start: Date?, end: Date?) -> String? {
    guard let start, let end else { return nil }
    return "\(start.uiFormat) ~ \(end.uiFormat)"
}
