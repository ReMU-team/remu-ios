//
//  CreateRecordCardViewModel.swift
//  ReMU
//
//  Created by 김진서 on 2/7/26.
//

import Foundation
import SwiftUI
import Moya
import Combine

@MainActor
final class CreateRecordCardViewModel: ObservableObject {

    private var starProvider: MoyaProvider<StarTargetType>?
    private var userSession: UserSessionKeychainService?

    @Published var isLoading = false
    @Published var errorMessage: String?

    // MARK: -  DI
    func inject(container: DIContainer) {
        self.starProvider = container.apiProviderStore.star()
        self.userSession = container.userSessionKeychain
    }
    
    // 임시 placeholder
    static func placeholder() -> CreateRecordCardViewModel {
        CreateRecordCardViewModel()
    }
    
    // MARK: - 기록 카드 생성 API
        func createRecord(
            galaxyId: Int,
            draft: RecordDraft
        ) async -> Bool {
            let model = RecordCardModel.from(draft: draft, dday: 0)
            
            let cardColor = draft.cardColor
            guard
                let starProvider,
                let userSession,
                let session = userSession.loadSession(for: .userSession),
                let accessToken = session.accessToken
            else {
                errorMessage = "로그인이 필요합니다."
                return false
            }
            
            let imageData = model.image?.jpegData(compressionQuality: 0.8)
            
            let request = CreateStarRequest(
                title: model.title,
                content: model.content,
                recordDate: Date().serverFormat,
                cardColor: cardColor,
                emojis: model.emojis,
                galaxyId: Int64(galaxyId)
            )
            
            isLoading = true
            defer { isLoading = false }
            
            do {
                _ = try await starProvider.requestAsync(
                    .createStar(
                        accessToken: accessToken,
                        request: request,
                        image: imageData,
                        fileName: imageData != nil ? "image.jpg" : nil,
                        mimeType: imageData != nil ? "image/jpeg" : nil
                    )
                )
                return true
            } catch {
                errorMessage = error.localizedDescription
                return false
            }
        }
}
