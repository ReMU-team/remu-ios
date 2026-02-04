////
////  KakaoService.swift
////  ReMU
////
////  Created by 원서우 on 1/25/26.
////
//
//import Foundation
//import AuthenticationServices
//
//@MainActor
//class SocialLoginService: NSObject, ASWebAuthenticationPresentationContextProviding {
//    
//    // 비동기적으로 토큰 뭉치를 반환하도록 설계
//    func startKakaoLogin() async throws -> (access: String, refresh: String) {
//        // TODO: 공식 서버 배포 시 URL 변경 필요
//        // 백엔드 설계가 OAuth2 Redirect 방식
//        let authURL = URL(string: "http://3.39.51.43:8080/oauth2/authorization/kakao")! // 운영 IP 반영
//        let callbackScheme = "remu"
//        
//        return try await withCheckedThrowingContinuation { continuation in
//            let session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: callbackScheme) { callbackURL, error in
//                if let error = error {
//                    continuation.resume(throwing: error)
//                    return
//                }
//                
//                guard let url = callbackURL,
//                      let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
//                      let access = components.queryItems?.first(where: { $0.name == "accessToken" })?.value,
//                      let refresh = components.queryItems?.first(where: { $0.name == "refreshToken" })?.value else {
//                    continuation.resume(throwing: NSError(domain: "AuthError", code: -1))
//                    return
//                }
//                
//                continuation.resume(returning: (access, refresh))
//            }
//            
//            session.presentationContextProvider = self
//            session.start()
//        }
//    }
//    
//    // ASWebAuthenticationPresentationContextProviding 준수
//        func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
//            return ASPresentationAnchor()
//        }
//}
