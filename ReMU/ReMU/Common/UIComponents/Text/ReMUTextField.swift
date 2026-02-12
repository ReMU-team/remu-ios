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

    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack(alignment: .leading) {

            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .font(.pt16)
                    .foregroundStyle(.grayScale5)
                    .padding(.horizontal, 16)
            }

            // 실제 입력
            TextField("", text: $text)
                .font(.pt16)
                .foregroundStyle(.grayScale9)
                .padding(.horizontal, 16)
                .focused($isFocused)
                .submitLabel(.done)
        }
        .frame(height: height)
        .background(Color.white.opacity(0.5))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.purpleC495E0)
        )
    }
}
