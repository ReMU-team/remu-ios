//
//  EmojiSelectableItem.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct EmojiSelectableItem: View {

    let emoji: EmojiItem
    let isSelected: Bool

    var body: some View {
        Image(emoji.assetName)
            .resizable()
            .frame(
                width: isSelected ? 64 : 48,
                height: isSelected ? 64 : 48
            )
            .scaleEffect(isSelected ? 1.15 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}
