//
//  CreateResultCardView.swift
//  ReMU
//
//  Created by 원서우 on 1/18/26.
//

import Foundation
import SwiftUI

struct CreateResultCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            navigation
            top
            middle
//            bottom
        }
    }

    
    // MARK: - navigation
    private var navigation: some View {
        CustomNavigationBar(
            title: "6인팟 스위스",
            onBack: {
                dismiss()
            }
        )
    }
    
    // MARK: - top
    private var top: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("회상 결과 분석")
                    .font(.pt24)
                    .foregroundStyle(.grayScale9)
                Text("여행 회고 완료!")
                    .font(.pt16)
                    .foregroundStyle(.grayScale5)
            }
            Spacer()
        }
        .padding()
    }
    
    // MARK: - middle
    private var middle: some View {
        VStack {
            ResultCardFlip()
                .padding(.top, 37)
                .padding(.bottom, 20)
            Text("카드를 클릭하면 뒷면이 보여요!")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
        }
    }
    
    
    
}

#Preview {
    CreateResultCardView()
}
