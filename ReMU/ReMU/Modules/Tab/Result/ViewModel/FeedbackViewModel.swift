////
////  FeedbackViewModel.swift
////  ReMU
////
////  Created by 원서우 on 2/10/26.
////
//
//import Foundation
//import Combine
//
//final class FeedbackViewModel: ObservableObject {
//
//    // MARK: - State
//    @Published var isLoading = false
//    @Published var feedbackContent: String?
//    @Published var errorMessage: String?
//
//    // MARK: - Dependency
//    private let galaxyId: Int
//    private let feedbackService: FeedbackServiceProtocol
//
//    init(
//        galaxyId: Int,
//        feedbackService: FeedbackServiceProtocol = FeedbackServiceImpl(
//            provider: APIProviderStore(
//                networkService: NetworkServiceImpl(
//                    userSessionKeychain: UserSessionKeychainServiceImpl()
//                )
//            ).feedback()
//        )
//    ) {
//        self.galaxyId = galaxyId
//        self.feedbackService = feedbackService
//    }
//    
//    // MARK: - Feedback API 생성 함수
//    func createFeedback() {
//        isLoading = true
//
//        feedbackService.createFeedback(galaxyId: galaxyId) { [weak self] result in
//            guard let self else { return }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//
//                switch result {
//                case .success(let response):
//                    self.feedbackContent = response.result?.content
//
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//
//
//    // MARK: - Feedback API 조회 함수
//    func fetchFeedback() {
//        isLoading = true
//
//        feedbackService.fetchFeedback(galaxyId: galaxyId) { [weak self] result in
//            guard let self else { return }
//
//            DispatchQueue.main.async {
//                self.isLoading = false
//
//                switch result {
//                case .success(let response):
//                    self.feedbackContent = response.result?.content
//
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//    
//    // MARK: - Feedback API 수정 함수
//    func updatePledgeAndRefreshFeedback() {
//        isLoading = true
//
//        // 1️⃣ 다짐 수정 API 성공했다고 가정
//        feedbackService.patchFeedback(galaxyId: galaxyId) { [weak self] result in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//
//                switch result {
//                case .success(let response):
//                    if let content = response.result?.content {
//                        self?.feedbackContent = content
//                    } else {
//                        self?.errorMessage = "피드백 데이터가 없습니다."
//                    }
//                case .failure(let error):
//                    self?.errorMessage = error.localizedDescription
//                }
//            }
//        }
//    }
//
//}
//
