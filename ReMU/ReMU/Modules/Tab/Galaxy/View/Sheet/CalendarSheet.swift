//
//  CalendarSheet.swift
//  ReMU
//
//  Created by 김진서 on 1/10/26.
//

import SwiftUI

struct CalendarSheet: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var startDate: Date?
    @Binding var endDate: Date?

    @State private var currentMonth: Date =
        Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month], from: Date())
        )!


    var body: some View {
        VStack(spacing: 20) {
            // 헤더
            HStack (spacing: 19){
                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: -1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.left")
                }


                Text(monthTitle)
                    .font(.headline)


                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.right")
                }
            }
            .padding(.top, 41)
            .padding(.bottom, 15)

            // 요일
            HStack {
                ForEach(["Su","Mo","Tu","We","Th","Fr","Sa"], id: \.self) {
                    Text($0)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.gray)
                }
            }

            // 날짜 그리드
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 7)) {
                ForEach(daysInMonth, id: \.self) { date in
                    CalendarDayCell(
                        date: date,
                        startDate: startDate,
                        endDate: endDate
                    ) {
                        handleDateTap(date)
                    }
                }
            }
            .id("\(startDate?.timeIntervalSince1970 ?? 0)-\(endDate?.timeIntervalSince1970 ?? 0)")

            Spacer()

            
            // 글 설명
            Text("비행기로 이동하시나요? ✈️\n 도착 예정일을 선택해주시면, 진짜 여행이 시작되는 날에 맞춰 기록을 준비할게요!\n\n비행이 아니라면, 그대로 ‘완료’를 눌러주세요.")
                .font(.pt15)
                .foregroundStyle(Color.grayScale8)
                .frame(width: 318, alignment: .topLeading)
                .padding(.top, 54)
                .padding(.bottom, 78)
                
            
            
            // 완료버튼
            PrimaryButton(
                title: "완료",
                backgroundColor: .purpleC495E0,
                isDisabled: startDate == nil || endDate == nil
            ) {
                dismiss()
            }
            .padding(.bottom, 14)
            
        }
        .padding(.horizontal, 36)
    }

    // MARK: - 날짜 탭 로직
    
    private func handleDateTap(_ date: Date) {
        guard date != Date.distantPast else { return }

        let tapped = date.dayOnly

        // 아무것도 선택 안 된 상태
        if startDate == nil {
            startDate = tapped
            endDate = nil
            return
        }

        // 시작일만 선택된 상태
        if let start = startDate, endDate == nil {
            if tapped < start {
                startDate = tapped
            } else {
                endDate = tapped
            }
            return
        }

        // 이미 기간 선택됨 -> 새로 시작
        startDate = tapped
        endDate = nil
    }



    // MARK: - Helpers
    private var monthTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        return formatter.string(from: currentMonth)
    }

    private var daysInMonth: [Date] {
        let calendar = Calendar.current
        let startOfMonth = calendar.date(
            from: calendar.dateComponents([.year, .month], from: currentMonth)
        )!

        let range = calendar.range(of: .day, in: .month, for: startOfMonth)!

        var days: [Date] = []

        let firstWeekday = calendar.component(.weekday, from: startOfMonth)
        for _ in 0..<(firstWeekday - 1) {
            days.append(Date.distantPast)
        }

        for day in range {
            if let date = calendar.date(
                from: DateComponents(
                    year: calendar.component(.year, from: startOfMonth),
                    month: calendar.component(.month, from: startOfMonth),
                    day: day
                )
            ) {
                days.append(date)
            }
        }

        return days
    }

}


struct CalendarDayCell: View {
    let date: Date
    let startDate: Date?
    let endDate: Date?
    let onTap: () -> Void

    var body: some View {
        Group {
            if date == Date.distantPast {
                Color.clear
                    .frame(height: 40)
            } else {
                Text(dayText)
                    .frame(width: 40, height: 40)
                    .background(background)
                    .foregroundStyle(foreground)
                    .clipShape(Circle())
                    .onTapGesture {
                        onTap()
                    }
            }
        }
    }

    private var dayText: String {
        String(Calendar.current.component(.day, from: date))
    }

    private var isSelected: Bool {
        guard let startDate else { return false }

        let d = date.dayOnly

        if let endDate {
            return d == startDate.dayOnly || d == endDate.dayOnly
        }

        return d == startDate.dayOnly
    }



    private var isInRange: Bool {
        guard let start = startDate, let end = endDate else { return false }

        let d = date.dayOnly
        return d > start.dayOnly && d < end.dayOnly
    }



    private var background: Color {
        if isSelected {
            return .purpleC495E0
        }
        if isInRange {
            return .purpleD9BCEA50
        }
        return .clear
    }

    private var foreground: Color {
        isSelected ? .white : .primary
    }
}

