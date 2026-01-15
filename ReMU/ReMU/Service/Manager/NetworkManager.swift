//
//  NetworkManager.swift
//  ReMU
//
//  Created by 원서우 on 1/14/26.
//

import Foundation
import Alamofire
import Moya

class NetworkManager {
    // 1. 싱글톤 인스턴스 (앱 어디서든 NetworkManager.shared 로 접근 가능)
    static let shared = NetworkManager()
    
    // 2. Moya Provider 생성
    // 지금은 테스트 모드(immediatelyStub)로 설정
    // 실제 서버와 통신 -> 괄호 안의 내용을 지우기
    let provider = MoyaProvider<UserAPI>(stubClosure: MoyaProvider.immediatelyStub)
    
    private init() { }
    
    // 3. 로그인 요청 함수
    func login(providerName: String, token: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        
        provider.request(.socialLogin(provider: providerName, token: token)) { result in
            switch result {
            case .success(let response):
                do {
                    // 성공하면 JSON 데이터를 LoginResponse 구조체로 변환(Decode)
                    let data = try response.map(LoginResponse.self)
                    completion(.success(data))
                } catch {
                    // 변환 실패 시 에러 전달
                    completion(.failure(error))
                }
                
            case .failure(let error):
                // 통신 실패 시 에러 전달
                completion(.failure(error))
            }
        }
    }
    
    // 4. 프로필 가져오기 함수
    func fetchProfile(completion: @escaping (Result<UserResponse, Error>) -> Void) {
        
        provider.request(.getMyProfile) { result in
            switch result {
            case .success(let response):
                do {
                    let data = try response.map(UserResponse.self)
                    completion(.success(data))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
