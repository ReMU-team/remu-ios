////
////  FeedbackServiceImpl.swift
////  ReMU
////
////  Created by 원서우 on 2/11/26.
////
//
//import Foundation
//import Moya
//
//final class FeedbackServiceImpl: FeedbackServiceProtocol {
//
//    private let provider: MoyaProvider<FeedbackTargetType>
//
//    init(provider: MoyaProvider<FeedbackTargetType>) {
//        self.provider = provider
//    }
//
//    // MARK: - 생성
//    func createFeedback(
//        galaxyId: Int,
//        completion: @escaping (Result<Void, Error>) -> Void
//    ) {
//        provider.request(.createFeedback(galaxyId: galaxyId)) { result in
//            switch result {
//            case .success:
//                completion(.success(()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    // MARK: - 조회
//    func fetchFeedback(
//        galaxyId: Int,
//        completion: @escaping (Result<FeedbackResponse, Error>) -> Void
//    ) {
//        provider.request(.fetchFeedback(galaxyId: galaxyId)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decoded = try JSONDecoder().decode(
//                        FeedbackResponse.self,
//                        from: response.data
//                    )
//                    completion(.success(decoded))
//                } catch {
//                    completion(.failure(error))
//                }
//
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    // MARK: - 수정
//    func patchFeedback(
//        galaxyId: Int,
//        completion: @escaping (Result<PatchFeedbackResponse, Error>) -> Void
//    ) {
//        provider.request(.patchFeedback(galaxyId: galaxyId)) { result in
//            switch result {
//            case .success(let response):
//                do {
//                    let decoded = try JSONDecoder().decode(
//                        PatchFeedbackResponse.self,
//                        from: response.data
//                    )
//                    completion(.success(decoded))
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//    }
//}
//
