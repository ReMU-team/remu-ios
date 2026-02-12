//
//  UserAPITest.swift
//  ReMU_Tests
//
//  Created by 김종수 on 2/3/26.
//

import Foundation
import Testing
import Moya
@testable import ReMU

struct UserResponseDTO: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let imageUrl: String
    let name: String
    let introduction: String
}

@Suite("UserAPI")
struct UserAPITest {
    @Test("NetworkService를 이용한 UserTargetType 샘플 데이터 테스트")
        func getUserInfoWithNetworkService() async throws {
            // Given
            let mockKeychain = MockUserSessionKeychainService()
            let networkService: NetworkService = NetworkServiceImpl(userSessionKeychain: mockKeychain)
            let userProvider = networkService.testProvider(for: UserTargetType.self)
            
            // when
            let response = try await userProvider.requestAsync(.checkUserProfile)
            let json = try JSONSerialization.jsonObject(with: response.data) as? [String: Any]
            
            // then
            #expect(json?["isSuccess"] as? Bool == true)
            #expect(json?["code"] as? String == "200")
            #expect(json?["message"] as? String == "success")
            #expect(json?["imageUrl"] as? String == "string")
            #expect(json?["name"] as? String == "종수")
            #expect(json?["introduction"] as? String == "빡세다")
        }
}
