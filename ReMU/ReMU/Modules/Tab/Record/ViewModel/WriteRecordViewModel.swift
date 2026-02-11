//
//  WriteRecordViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/30/26.
//

import Foundation
import SwiftUI
import PhotosUI
import Combine

@MainActor
final class WriteRecordViewModel: ObservableObject {
    
    // MARK: - Sheet Control
    @Published var isEmojiSheetPresented = false
    @Published var isColorSheetPresented = false
    @Published var isPhotoPickerPresented = false
    
    // MARK: - Input Values
    @Published var title: String = ""
    @Published var content: String = ""
    
    // MARK: - Emoji
    let emojis: [EmojiItem] = EmojiCatalog.all
    @Published var selectedEmojis: [EmojiItem] = []        // 최종 적용
    @Published var tempSelectedEmojis: [EmojiItem] = []    // 시트 내부 선택 (최대 3)
    
    // MARK: - Card Color
       let cardColors: [CardColor] = CardColor.allCases
       @Published var selectedCardColor: CardColor?
    
    // MARK: - Photo
    @Published var selectedPhoto: UIImage?
    
    // MARK: - Emoji Sheet Logic
    func openEmojiSheet() {
        // 기존 선택값을 시트에 복사
        tempSelectedEmojis = selectedEmojis
        isEmojiSheetPresented = true
    }
    
    func toggleEmoji(_ emoji: EmojiItem) {
        if tempSelectedEmojis.contains(where: { $0.id == emoji.id }) {
            // 이미 선택됨 → 취소
            tempSelectedEmojis.removeAll { $0.id == emoji.id }
        } else {
            // 새로 선택
            guard tempSelectedEmojis.count < 3 else { return }
            tempSelectedEmojis.append(emoji)
        }
    }
    
    func confirmEmojiSelection() {
        // 시트 선택 결과를 최종 반영
        selectedEmojis = tempSelectedEmojis
        isEmojiSheetPresented = false
    }
    
    func removeEmoji(_ emoji: EmojiItem) {
        selectedEmojis.removeAll { $0.id == emoji.id }
    }
    
    // MARK: - Photo Picker
    func setPhoto(from item: PhotosPickerItem) async {
        if let data = try? await item.loadTransferable(type: Data.self),
           let image = UIImage(data: data) {
            self.selectedPhoto = image
        }
    }
    
    // MARK: - Draft
    func makeDraft() -> RecordDraft {
        RecordDraft(
            title: title,
            content: content,
            emojis: selectedEmojis.map { $0.id },
            image: selectedPhoto,
            cardColor: selectedCardColor?.assetName ?? "planet_1"
        )
    }
    
    // MARK: - 버튼 활성화 조건
    var isValid: Bool {
        let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedContent = content.trimmingCharacters(in: .whitespacesAndNewlines)

        return trimmedTitle.count >= 2 &&
               trimmedTitle.count <= 32 &&
               trimmedContent.count >= 2 &&
               !selectedEmojis.isEmpty &&
               selectedCardColor != nil
    }

}




