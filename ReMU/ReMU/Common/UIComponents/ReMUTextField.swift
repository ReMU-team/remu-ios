//
//  ReMUTextField.swift
//  ReMU
//
//  Created by 원서우 on 1/10/26.
//

import Foundation
import SwiftUI

struct ReMUTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color(UIColor.placeholderText))
                    .padding(.horizontal, 20)
                    .padding(.vertical, 24)
            }
            
            TextEditor(text: $text)
                .padding(16)
                .scrollContentBackground(.hidden)
                .frame(height: 160)
        }
        .frame(maxWidth: .infinity)
        .background(Color.white.opacity(0.36))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .inset(by: 0.5)
                .stroke(Color(red: 0.13, green: 0.13, blue: 0.28), lineWidth: 1)
        )
    }
}

//사용예시
//    @State private var id: String = ""
//    @State private var password: String = ""
//
//    var body: some View {
//        VStack {
//            ReMUTextField(placeholder: "아이디를 입력하세요", text: $id)
//        }
//    }

