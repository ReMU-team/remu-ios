//
//  ResultViewModel.swift
//  ReMU
//
//  Created by 원서우 on 1/28/26.
//

import Foundation
import Combine
import SwiftUI

class ResultViewModel: ObservableObject {
    
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var reviewResult: ReviewResult?

    
    // MARK: - Dependency
    private let userId: Int
    private let galaxyId: Int
    
    // MARK: - Network Service
    private let resultService: ResultServiceProtocol
    
    init(
        userId: Int,
        galaxyId: Int,
        resultService: ResultServiceProtocol = ResultServiceImpl(
            provider: APIProviderStore(
                networkService: NetworkServiceImpl(
                    userSessionKeychain: UserSessionKeychainServiceImpl()
                )
            ).result()
        )
    ) {
        self.userId = userId
        self.galaxyId = galaxyId
        self.resultService = resultService
    }

    // MARK: - Result API 생성 함수
    func submitResult(completion: @escaping () -> Void) {
        let request = makeCreateResultRequest()

        resultService.createResult(
            userId: userId,
            galaxyId: galaxyId,
            request: request
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion()
                case .failure(let error):
                    print("회고 생성 실패:", error)
                }
            }
        }
    }
    
    // MARK: - Result API 조회 함수
    func fetchResult() {
        isLoading = true

        resultService.checkResult(
            userId: userId,
            galaxyId: galaxyId
        ) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let response):
                    self.reviewResult = self.makeReviewResult(from: response)

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    // MARK: - Result API 수정 함수
    func patchResult(completion: @escaping () -> Void) {
        let request = makePatchResultRequest()

        resultService.patchResult(
            userId: userId,
            galaxyId: galaxyId,
            request: request
        ) { [weak self] result in
            guard let self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success:
                    // ✅ 수정 후 최신 데이터 다시 조회
                    self.fetchResult()
                    completion()

                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }


    
    // MARK: - 생성 Mapping
    func makeCreateResultRequest() -> createResultRequest {
        return createResultRequest(
            emojiId: selectedEmoji?.id ?? "",
            reflection: review,
            review: pledges.map { $0.content }
        )
    }
    
    // MARK: - 조회 Mapping
    private func makeReviewResult(
        from response: CheckResultResponse
    ) -> ReviewResult {
        ReviewResult(
            galaxyId: response.galaxyId,
            travelEmojiImageName: response.travelEmojiImageName,
            overallContent: response.overallContent,
            aiFeedback: response.aiFeedback
        )
    }
    
    // MARK: - 수정 Mapping
    private func makePatchResultRequest() -> patchResultRequest {
        patchResultRequest(
            emojiId: selectedEmoji?.id ?? "",
            reflection: review,
            reviews: pledges.map {
                patchresultDetail(
                    reviewId: $0.reviewId,
                    reviewContent: $0.content,
                    isResolutionFulfilled: $0.isFulfilled
                )
            }
        )
    }



    // MARK: - UI용 변환 함수
//    func createFinalResult() -> ReviewResult {
//        return ReviewResult(
//            galaxyId: 0, // 임시 ID
//            travelEmojiImageName: "emoji_name", // 임시 이미지명
//            overallContent: review,
//            aiFeedback: nil
//        )
//    }
    
    // MARK: - State(UI)
    // 다짐 목록 (PledgeItem은 ReviewResult.swift에 정의됨)
    @Published var pledges: [PledgeItem] = [
        PledgeItem(reviewId: 1, title: "아이스크림 사먹기", content: ""),
        PledgeItem(reviewId: 1, title: "현지인 맛집 찾아가기", content: ""),
        PledgeItem(reviewId: 1, title: "베스트컷 한 장 찍기", content: "")
    ]
    
    // 여행 후기
    @Published var review: String = ""
    
    // MARK: - Emoji
    @Published var isEmojiSheetPresented = false
    @Published var tempSelectedEmojis: [EmojiItem] = []
    @Published var selectedEmojis: [EmojiItem] = []

    let emojis = EmojiCatalog.all
    
    var selectedEmoji: EmojiItem? {
        selectedEmojis.first
    }

    func confirmEmojiSelection() {
        selectedEmojis = tempSelectedEmojis
        //tempSelectedEmoji = nil
        isEmojiSheetPresented = false
    }

    func openEmojiSheet() {
        //tempSelectedEmoji = selectedEmoji
        isEmojiSheetPresented = true
    }
}
