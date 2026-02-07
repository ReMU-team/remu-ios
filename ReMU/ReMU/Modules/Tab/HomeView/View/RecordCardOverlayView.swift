//
//  RecordCardOverlayView.swift
//  ReMU
//
//  Created by 김진서 on 2/6/26.
//

import SwiftUI

struct RecordCardOverlayView: View {
    @Binding var selectedTab: CardTab
    let onClose: () -> Void
    let onWriteResult: () -> Void
    
    var body: some View {
        ZStack {
            
            //TODO: 오류 수정 필요
            RecordCardFlip(model: RecordCardModel)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onTapGesture { } // 닫힘 방지
    }
}



#Preview {
    RecordCardOverlayPreview()
}

private struct RecordCardOverlayPreview: View {
    @State private var selectedTab: CardTab = .pledge

    var body: some View {
        ZStack {
            // 홈 배경 흉내
            Color.blue212148
                .ignoresSafeArea()

            RecordCardOverlayView(
                selectedTab: $selectedTab,
                onClose: {
                    print("닫기 눌림")
                },
                onWriteResult: {
                    print("회고 작성")
                }
            )
        }
    }
}

