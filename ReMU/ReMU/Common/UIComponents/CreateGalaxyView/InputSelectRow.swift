//
//  InputSelectRow.swift
//  ReMU
//
//  Created by 김진서 on 1/11/26.
//

import SwiftUI

struct InputSelectRow: View {
    let title: String
    let value: String?
    let placeholder: String
    let action: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // 제목
            Text(title)
                .font(.pt18)
                .foregroundStyle(.grayScale9)

            // 선택 영역
            Button(action: action) {
                HStack {
                    Text(value ?? placeholder)
                        .font(.pt16)
                        .foregroundStyle(value == nil ? .purpleC495E0 : .grayScale9) // 선택해주세요 -> 결과 글 색

                    Spacer()

                    Image(systemName: "chevron.right") // TODO: - 이미지 변경 예정
                        .foregroundStyle(.grayScale5)
                }
                .padding(15)
                .background(.purpleD9BCEA50)
                .cornerRadius(12)
            }
        }
    }
}



//// 사용법
//
//    InputSelectRow(
//        title: "언제 떠날까요?",
//        value: dateRangeText(start: startDate, end: endDate),
//        placeholder: "클릭하여 날짜를 입력해주세요"
//    ) {
//        showCalendar = true
//    }
//    .sheet(isPresented: $showCalendar) {
//        CalendarSheet(
//            startDate: $startDate,
//            endDate: $endDate
//        )
//    }
//


