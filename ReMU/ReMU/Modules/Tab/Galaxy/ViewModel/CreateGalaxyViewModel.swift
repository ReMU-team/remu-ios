//
//  CreateGalaxyViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/23/26.
//

import Foundation
import Combine
import Moya

@MainActor
final class CreateGalaxyViewModel: ObservableObject {
    
    @Published var createdGalaxy: Galaxy?
    
    
    @Published var destination: String?
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var galaxyName: String = ""
    @Published var selectedGalaxyImageName: String?
    
    @Published var showPlaceSearch = false
    @Published var showCalendar = false
    
    private let provider: MoyaProvider<GalaxyTargetType>
    private let keychain: UserSessionKeychainService
    
    init(container: DIContainer) {
        self.provider = container.apiProviderStore.galaxy()
        self.keychain = container.userSessionKeychain
    }
    
    var isFinishEnabled: Bool {
        destination != nil &&
        startDate != nil &&
        endDate != nil &&
        !galaxyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGalaxyImageName != nil
    }
    
    // 은하 생성 API
    func createGalaxy() async {
        guard
            let session = keychain.loadSession(for: .userSession),
            let accessToken = session.accessToken,
            let destination,
            let startDate,
            let endDate,
            let icon = selectedGalaxyImageName
        else { return }
        
        let request = CreateGalaxyRequest(
            name: galaxyName,
            startDate: startDate,
            arrivalDate: startDate,
            endDate: endDate,
            emojiResourceName: icon,
            googlePlaceId: "temp",
            placeName: destination
        )
        
        do {
            let response = try await provider.requestAsync(
                .createGalaxy(accessToken: accessToken, requset: request)
            )
            
            let dto = try JSONDecoder().decode(CreateGalaxyResponse.self, from: response.data)
            
            guard let result = dto.result else { return }
            
            self.createdGalaxy = Galaxy(
                serverId: result.galaxyId,
                title: result.name,
                destination: destination,
                startDate: startDate,
                endDate: endDate,
                totalDay: Calendar.current.dateComponents([.day], from: startDate, to: endDate).day! + 1,
                galaxyIcon: icon,
                stars: []
            )
            
        } catch {
            print("❌ 은하 생성 실패:", error)
        }
    }
}
