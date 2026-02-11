//
//  RecordCardOverlayView.swift
//  ReMU
//
//  Created by 김진서 on 2/6/26.
//

import SwiftUI

struct RecordCardOverlayView: View {
    @Binding var selectedTab: CardTab
    let model: RecordCardModel
    let onClose: () -> Void
    let onEditRecord: () -> Void
    
    var body: some View {
        ZStack {
            
            RecordCardFlip(model: model)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture { } // 닫힘 방지
    }
}



#Preview {
    RecordCardOverlayPreview()
}

private struct RecordCardOverlayPreview: View {
    @State private var selectedTab: CardTab = .review

    var body: some View {
        ZStack {
            Color.blue212148
                .ignoresSafeArea()

            RecordCardOverlayView(
                selectedTab: $selectedTab,
                model: RecordCardModel(
                    galaxyName: "스위스 여행",
                    travelPeriodText: "25/10/29-25/11/10",
                    title: "첫 기록",
                    image: nil,
                    imageUrl: nil, 
                    dday: 3,
                    dateText: "10.31",
                    content: "오늘은 정말 좋은 하루였다.",
                    emojis: ["smile", "heart"]
                ),
                onClose: {
                    print("닫기")
                },
                onEditRecord: {
                    print("기록 수정")
                }
            )
        }
    }
}



