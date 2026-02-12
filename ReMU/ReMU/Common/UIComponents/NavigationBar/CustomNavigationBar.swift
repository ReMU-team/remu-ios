//
//  CustomNavigationBar.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation
import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let onBack: () -> Void

    var body: some View {
        ZStack {
            // 가운데 타이틀
            Text(title)
                .font(.pt20)
                .foregroundStyle(Color.grayScale9)

            HStack {
                Button {
                    onBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(Color.grayScale9)
                }

                Spacer()
            }
        }
        .padding(.top, 11)
        .padding(.horizontal, 20)
    }
}

// 사용법
//struct NavigationBarExampleView: View {
//    @Environment(\.dismiss) private var dismiss
//    
//    var body: some View {
//        CustomNavigationBar(
//                        title: "네비게이션바 이름",
//                        onBack: {
//                            dismiss()
//                        }
//                    )
//    }
//}
