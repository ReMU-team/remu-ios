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
    
    // MARK: - Emoji
    let emojis: [EmojiItem] = EmojiCatalog.all
    
    @Published var selectedEmojis: [EmojiItem] = []        // 최종 적용
    @Published var tempSelectedEmojis: [EmojiItem] = []    // 시트 내부 선택 (최대 3)
    
    // MARK: - Emoji Sheet LifeCycle
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
    
    // MARK: - Photo
    @Published var selectedPhoto: UIImage?
    
    func setPhoto(from item: PhotosPickerItem?) {
        guard let item else { return }
        
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                self.selectedPhoto = image
            }
        }
    }
    
    // MARK: - Card Color 
       let cardColors: [CardColor] = CardColor.allCases
       @Published var selectedCardColor: CardColor?
}
