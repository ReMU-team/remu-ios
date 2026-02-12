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

        guard
            let starProvider,
            let userSession,
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            errorMessage = "로그인이 필요합니다."
            return false
        }

        var imageData: Data? = nil

        if let image = draft.image {
            let resized = image.resized(maxSize: 800)
            imageData = resized.jpegData(compressionQuality: 0.3)
        }

        let request = CreateStarRequest(
            title: draft.title,
            content: draft.content,
            recordDate: Date().serverFormat,
            cardColor: draft.cardColor,
            emojis: draft.emojis,
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
