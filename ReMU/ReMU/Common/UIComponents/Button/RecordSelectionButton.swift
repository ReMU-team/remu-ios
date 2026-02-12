//
//  RecordSelectionButton.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct RecordSelectionButton: View {
    let title: String
    var body: some View {
        HStack(alignment: .center) {
            Text(title)
                .font(.pt16)
                .foregroundStyle(.blue212148)
        }
        .frame(width: 77, height: 41)
//        .padding(.horizontal, 9)
//        .padding(.vertical, 12)
        .background(Color.purpleD9BCEA.opacity(0.5))
        .cornerRadius(12)
    }
}

#Preview {
    RecordSelectionButton(title: "카드색상")
}
