//
//  ReMUTextField.swift
//  ReMU
//
//  Created by 원서우 on 1/10/26.
//

import SwiftUI

struct ReMUTextField: View {
    @Binding var text: String
    let placeholder: String
    let height: CGFloat
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // 1. Placeholder (텍스트가 비었을 때만 표시)
            if text.isEmpty {
                Text(placeholder)
                    .font(.pt16)
                    .foregroundStyle(.grayScale5)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, (height > 60) ? 0 : 4)
            }
            
            // 2. 실제 입력창
            TextEditor(text: $text)
                .scrollContentBackground(.hidden)
                .padding(8)
        }
        .frame(height: height)
        .background(Color.white.opacity(0.5)) // 반투명 흰색 배경
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.purpleC495E0)
        )
    }
}

// MARK: - 사용 방법
//    @State private var id: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//        VStack {
//            ReMUTextField(text: $id, placeholder: "아이디를 입력하세요", height: 40)
//        }
//    }

