//
//  SwiftUIView.swift
//  ReMU
//
//  Created by 김진서 on 1/10/26.
//

import SwiftUI
import Combine

struct NextView: View {
    // 장소 관련
    @State private var destination: String?
    @State private var showPlaceSearch = false
    
    // 캘린더 관련
    @State private var showCalendar = false
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    var body: some View {
        VStack {
            
            
            InputSelectRow(
                title: "어디로 떠날까요?",
                value: destination,
                placeholder: "클릭하여 장소를 검색해주세요"
            ) {
                showPlaceSearch = true
            }
            .sheet(isPresented: $showPlaceSearch) {
                PlaceSearchSheet(
                    selectedPlace: $destination
                )
            }
            
            InputSelectRow(
                title: "언제 떠날까요?",
                value: dateRangeText(start: startDate, end: endDate),
                placeholder: "클릭하여 날짜를 입력해주세요"
            ) {
                showCalendar = true
            }
            .sheet(isPresented: $showCalendar) {
                CalendarSheet(
                    startDate: $startDate,
                    endDate: $endDate
                )
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    NextView()
}
