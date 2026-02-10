//
//  GalaxyCheckViewModel.swift
//  ReMU
//
//  Created by 김진서 on 2/11/26.
//

import Foundation
import Combine
import Moya

@MainActor
final class GalaxyCheckViewModel: ObservableObject {

    @Published var galaxies: [GalaxySummary] = []
    @Published var isLoading = false

    private let container: DIContainer
    private let userSession: UserSessionKeychainService

    init(container: DIContainer) {
        self.container = container
        self.userSession = container.userSessionKeychain
    }

    func fetchGalaxyList() async {
        guard
            let session = userSession.loadSession(for: .userSession),
            let accessToken = session.accessToken
        else {
            print("❌ accessToken 없음")
            return
        }

        isLoading = true
        defer { isLoading = false }

        let provider = container.apiProviderStore.galaxy()

        do {
            let response = try await provider.requestAsync(
                .fetchGalaxyList(accessToken: accessToken, page: 0, size: 20)
            )

            let dto = try JSONDecoder().decode(GalaxyListResponse.self, from: response.data)
            self.galaxies = dto.result?.galaxies ?? []

        } catch {
            print("❌ 은하 리스트 조회 실패:", error)
        }
    }
}
