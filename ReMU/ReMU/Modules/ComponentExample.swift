//
//  ComponentExample.swift
//  ReMU
//
//  Created by 원서우 on 1/11/26.
//

import Foundation
import SwiftUI

struct ComponentExample: View {
//    @State private var id: String = ""
//
//    var body: some View {
//        VStack {
//            ReMUTextField(placeholder: "아이디를 입력하세요", text: $id)
//        }
//        .padding()
//    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("알림 테스트")
                .font(.title)
            
            // 1. 권한 요청 버튼
            Button("알림 권한 요청하기") {
                NotificationService.shared.requestPermission()
            }
            .buttonStyle(.bordered)
            
            // 2. 알림 발송 버튼
            Button("도착 알림 받기 (3초 뒤)") {
                NotificationService.shared.sendArrivalNotification()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ComponentExample()
}
