//
//  EmojiPickerSheet.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct EmojiPickerSheet: View {

    let emojis: [EmojiItem]

    @Binding var selectedEmoji: EmojiItem?
    let onConfirm: () -> Void
    let onClose: () -> Void

    var body: some View {
        VStack {
//            // 닫기 버튼
//            HStack {
//                Spacer()
//                Button(action: onClose) {
//                    Image(systemName: "xmark")
//                }
//            }
//            .padding(.horizontal, 24)
//            .padding(.top, 20)
//            .padding(.bottom, 10)
            
            // 헤더
            HStack {
                Text("이모지")
                    .font(.pt16)
                    .foregroundStyle(.grayScale9)
                Spacer()
                
            }
            .padding(.horizontal, 40)
            .padding(.top, 44)
            .padding(.bottom, 16)

            // 이모지 리스트
            let columns = Array(
                repeating: GridItem(.flexible(), spacing: 16),
                count: 5
            )

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(emojis) { emoji in
                    EmojiSelectableItem(
                        emoji: emoji,
                        isSelected: selectedEmoji?.id == emoji.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            selectedEmoji = emoji
                        }
                    }
                }
            }
            .padding(.horizontal, 40)


            Spacer()

            // 추가하기 버튼
            PrimaryButton(
                title: "추가하기",
                backgroundColor: selectedEmoji == nil ? .grayScale3 : .purpleC495E0
            ) {
                onConfirm()
            }
            .disabled(selectedEmoji == nil)
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 54)
        .presentationDetents([.fraction(0.5)]) // 화면의 50%만 보이게 설정
        .presentationDragIndicator(.visible)
    }
    
}

