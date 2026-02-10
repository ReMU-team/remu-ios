//
//  FeedbackService.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation
import Moya

final class FeedbackService {

    private let provider: MoyaProvider<FeedbackTargetType>

    init(providerStore: APIProviderStore) {
        self.provider = providerStore.feedback()
    }

    func createFeedback(
        accessToken: String,
        galaxyId: Int,
        request: FeedbackRequest,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        provider.request(.createFeedback(accessToken: accessToken, galaxyId: galaxyId)) { result in
            self.handle(result: result, completion: completion)
        }
    }

    func fetchFeedback(
        accessToken: String,
        galaxyId: Int,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        provider.request(.fetchFeedback(accessToken: accessToken, galaxyId: galaxyId)) { result in
            self.handle(result: result, completion: completion)
        }
    }

    private func handle(
        result: Result<Moya.Response, MoyaError>,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        switch result {
        case .success(let response):
            do {
                let decoded = try JSONDecoder()
                    .decode(FeedbackResponse.self, from: response.data)
                guard let feedback = decoded.result?.content else {
                    completion(.failure(NetworkError.emptyResult))
                    return
                }

                completion(.success(feedback))
            } catch {
                completion(.failure(error))
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }

}
