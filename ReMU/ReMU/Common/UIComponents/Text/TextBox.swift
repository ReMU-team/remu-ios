//
//  TextBox.swift
//  ReMU
//
//  Created by 김진서 on 1/10/26.
//

import Foundation
import SwiftUI

struct TextBox: View {
    var text: String? = nil
    var isExpanded: Bool = false

    var body: some View {
        Text(text ?? "")
            .font(.pt16)
            .foregroundStyle(.grayScale8)
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding(15)
            // 크기 확장 여부
            .frame(maxHeight: isExpanded ? .infinity : nil)
            .background(.purpleD9BCEA50)
            .cornerRadius(10)
    }
}
