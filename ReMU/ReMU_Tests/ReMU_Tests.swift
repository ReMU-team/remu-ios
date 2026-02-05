//
//  ReMU_Tests.swift
//  ReMU_Tests
//
//  Created by 김종수 on 2/2/26.
//

import SwiftUI
import Testing
import Alamofire
import Moya
@testable import ReMU

/// 실제 키체인 값에 영향을 주지 않기 위해 메모리에서 돌아도록 키체인 서비스 제작
final class MockUserSessionKeychainService: UserSessionKeychainService {
    var session: UserInfo?

    func saveSession(_ session: UserInfo, for type: KeychainKey) -> Bool {
        self.session = session
        return true
    }

    func loadSession(for type: KeychainKey) -> UserInfo? {
        return session
    }

    func deleteSession(for type: KeychainKey) {
        session = nil
    }
}

@Suite("인증 관련 테스트")
struct AuthAPITest {

    @Test("AuthTargetType 샘플 데이터 테스트")
    func authLogin() async throws {
        // Given
        let provider = MoyaProvider<AuthTargetType>(stubClosure: MoyaProvider.immediatelyStub,
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
        
        // when
        let response = try await provider.requestAsync(.socialLogin)
        let json = try JSONDecoder().decode(LoginResponse.self, from: response.data)
        
        // then
        #expect(json.isSuccess == true)
        #expect(json.result?.accessToken == "sample_access_token")
        #expect(json.result?.isNewUser == true)
    }
    
    @Test("로그인 실패 시 에러가 발생해야 한다")
    func authLoginFailure() async throws {
        
        // given
        let endpointClosure = { (target: AuthTargetType) -> Endpoint in
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: {
                    .networkResponse(401, Data())
                },
                method: (target as APITargetType).method,
                task: (target as APITargetType).task,
                httpHeaderFields: target.headers
            )
        }
        
        let provider = MoyaProvider<AuthTargetType>(
            endpointClosure: endpointClosure,
            stubClosure: MoyaProvider.immediatelyStub,
            plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))]
        )

        // When & Then
        await #expect(throws: MoyaError.self, performing: {
            try await provider.requestAsync(.socialLogin)
        })
    }
    
    @Test("adapt 함수를 통해 accessToken이 Authorization 헤더에 포함되어야 한다")
    func addAuthorizationHeader() async throws {
        // Given
        let mockKeychain = MockUserSessionKeychainService()
        mockKeychain.session = UserInfo(
            accessToken: "access-token-123",
            refreshToken: "refresh-token-xyz"
        )
        let tokenProvider = TokenProvider(userSessionKeychain: mockKeychain)
        let refresher = AccessTokenRefresher(tokenProviding: tokenProvider)
        
        var adaptedRequest: URLRequest?
        guard let url = URL(string: "https://example.com") else { return }
        let request = URLRequest(url: url)
        
        // When
        adaptedRequest = try await withCheckedThrowingContinuation { continuation in
            refresher.adapt(request, for: .default) { result in
                switch result {
                case .success(let request):
                    continuation.resume(returning: request)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
        
        // Then
        let header = adaptedRequest?.value(forHTTPHeaderField: "Authorization")
        #expect(header == "Bearer access-token-123")
    }
}
