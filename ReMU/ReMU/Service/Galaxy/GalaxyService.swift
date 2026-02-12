//
//  GalaxyService.swift
//  ReMU
//
//  Created by 원서우 on 2/12/26.
//

import Foundation
import Moya

protocol GalaxyServiceProtocol {
    func checkGalaxy(galaxyId: Int, completion: @escaping (Result<GalaxyResponse, Error>) -> Void)
}

final class GalaxyServiceImpl: GalaxyServiceProtocol {
    private let provider: MoyaProvider<GalaxyTargetType>
    
    init(provider: MoyaProvider<GalaxyTargetType>) {
        self.provider = provider
    }
    
    func checkGalaxy(galaxyId: Int, completion: @escaping (Result<GalaxyResponse, Error>) -> Void) {
        provider.request(.fetchGalaxyDetail(galaxyId: galaxyId)) { result in
            switch result {
            case .success(let response):
                do {
                    // GalaxyResponse 타입은 프로젝트에 정의된 것을 사용하세요 (CreateGalaxyResponse와 다를 수 있음)
                    // 여기서는 CheckGalaxyResponse라고 가정합니다.
                    let decoded = try JSONDecoder().decode(CheckGalaxyResponse.self, from: response.data)
                    completion(.success(decoded.result)) // result 내부 객체 전달
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// 응답 모델 (이미 있다면 생략 가능)
struct CheckGalaxyResponse: Decodable {
    let result: GalaxyResponse
}

struct GalaxyResponse: Decodable {
    let galaxyId: Int
    let name: String
    let startDate: String
    let endDate: String
}
