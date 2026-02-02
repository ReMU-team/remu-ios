//
//  PrimaryButton.swift
//  ReMU
//
//  Created by 김진서 on 1/10/26.
//


import SwiftUI

/// PrimaryButton
/// : 완료, 다음 버튼 등 기본 버튼입니다.
/// - Note:
///   - Navigation / 조건 제어는 View에서 처리합니다.
///   - 버튼은 action 트리거 역할만 합니다.

struct PrimaryButton: View {
    let title: String
    let backgroundColor: Color
    let textColor: Color
    let isDisabled: Bool
    let action: () -> Void

    init(
        title: String,
        backgroundColor: Color = .blue505083,
        textColor: Color = .white,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button {
            guard !isDisabled else { return }
            action()
        } label: {
            Text(title)
                .font(.pt16)
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity) // View에서 패딩을 이용해서 가로 길이 설정!
                .padding(.vertical, 16)
                .background(isDisabled ? .purpleC495E0.opacity(0.4) : backgroundColor)
                .cornerRadius(12)
        }
        .disabled(isDisabled)
    }
}

// MARK: - 사용 방법
//다음 화면으로 넘어갈 때
//@State private var goNext = false
//PrimaryButton(title: "다음") {
//    goNext = true
//    print("다음 버튼 클릭")
//}
//.navigationDestination(isPresented: $goNext) {
//    NextView()
//}

// 모르는 게 있다면 티모에게 물어보세요
