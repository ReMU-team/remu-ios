//
//  TextBox.swift
//  ReMU
//
//  Created by 김진서 on 1/10/26.
//

import Foundation
import SwiftUI

struct TextBox: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.pt16)
            .foregroundStyle(.grayScale8) // TODO: 색 변경 필요
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(15)
            .background(.purpleD9BCEA50)
            .cornerRadius(10)
    }
}
