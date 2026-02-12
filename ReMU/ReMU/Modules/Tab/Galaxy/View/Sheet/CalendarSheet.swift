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
                        .foregroundStyle(.grayScale9)
                }


                Text(monthTitle)
                    .font(.headline)


                Button {
                    currentMonth = Calendar.current.date(byAdding: .month, value: 1, to: currentMonth)!
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.grayScale9)

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

            
            VStack(spacing: 12) {
                
                // 위 보라 Divider
                Rectangle()
                    .fill(Color.purpleC495E0.opacity(0.3))
                    .frame(height: 1)
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.gray)

                    Spacer()

                    // 출발일
                    Text(startDate?.uiFormat ?? "출발일")
                        .font(.pt15)
                        .foregroundColor(startDate == nil ? .gray : .black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            startDate != nil && endDate == nil
                            ? Color.purpleC495E0.opacity(0.2)
                            : Color.clear
                        )
                        .clipShape(Capsule())
                        .frame(width: 90)


                    Spacer()

                    Image(systemName: "arrow.right")
                        .foregroundColor(.gray)

                    Spacer()

                    // 종료일
                    Text(endDate?.uiFormat ?? "종료일")
                        .font(.pt15)
                        .foregroundColor(endDate == nil ? .gray : .black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            endDate != nil
                            ? Color.purpleC495E0.opacity(0.2)
                            : Color.clear
                        )
                        .clipShape(Capsule())
                        .frame(width: 90)


                    Spacer()
                }
                
                // 아래 보라 Divider
                Rectangle()
                    .fill(Color.purpleC495E0.opacity(0.3))
                    .frame(height: 1)
            }
            .padding(.vertical, 8)

            Spacer()
            
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
                    .overlay(
                        Circle()
                            .stroke(
                                isToday && !isSelected ? Color.purpleC495E0 : .clear,
                                lineWidth: 2
                            )
                    )
                    .foregroundStyle(foreground)
                    .clipShape(Circle())
                    .onTapGesture {
                        onTap()
                    }
            }
        }
    }
    
    /// 오늘 날짜
    private var isToday: Bool {
        Calendar.current.isDateInToday(date)
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
        if isSelected {
            return .white
        }
        if isToday {
            return .purpleC495E0
        }
        return .primary
    }

}

