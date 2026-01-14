//
//  PledgeInputView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct PledgeInputView: View {
    @Binding var text: String
    let example: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ReMUTextField(
                placeholder: "떠나기 전의 마음을 남겨주세요",
                text: $text
            )

            Text(example)
                .font(.pt12)
                .foregroundStyle(.grayScale5)
        }
    }
}
