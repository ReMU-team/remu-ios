//
//  EmojiPickerSheet.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct EmojiPickerSheet: View {

    let emojis: [EmojiItem]

    /// 시트 내부에서 관리되는 선택 상태 (단일/다중 공용)
    @Binding var selectedEmojis: [EmojiItem]

    /// 최대 선택 개수 (예: 1, 3)
    let maxSelection: Int

    let onConfirm: () -> Void
    let onClose: () -> Void

    var body: some View {
        VStack {

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
                        isSelected: selectedEmojis.contains { $0.id == emoji.id }
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            toggleEmoji(emoji)
                        }
                    }
                }
            }
            .padding(.horizontal, 40)

            Spacer()

            // 추가하기 버튼
            PrimaryButton(
                title: "추가하기",
                backgroundColor: selectedEmojis.isEmpty
                    ? .grayScale3
                    : .purpleC495E0
            ) {
                onConfirm()
            }
            .disabled(selectedEmojis.isEmpty)
            .padding(.horizontal, 40)
        }
        .padding(.bottom, 54)
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
    }

    // MARK: - Selection Logic
    private func toggleEmoji(_ emoji: EmojiItem) {
        if let index = selectedEmojis.firstIndex(where: { $0.id == emoji.id }) {
            // 이미 선택됨 → 취소
            selectedEmojis.remove(at: index)
        } else {
            // 새 선택
            guard selectedEmojis.count < maxSelection else { return }
            selectedEmojis.append(emoji)
        }
    }
}

