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
    @Published var aiFeedback: String?
    @Published var galaxyTitle: String = ""
    @Published var travelDate: String = ""
    
    // MARK: - Dependency
    private let appState: AppState
    private let resultService: ResultServiceProtocol
    private let pledgeService: PledgeServiceProtocol
    private let galaxyService: GalaxyServiceProtocol
    private let feedbackService: FeedbackServiceProtocol
    
    // MARK: - Network Service
    init(
        appState: AppState,
        resultService: ResultServiceProtocol,
        pledgeService: PledgeServiceProtocol,
        galaxyService: GalaxyServiceProtocol,
        feedbackService: FeedbackServiceProtocol
    ) {
        self.appState = appState
        self.resultService = resultService
        self.pledgeService = pledgeService
        self.galaxyService = galaxyService
        self.feedbackService = feedbackService
    }

    // MARK: - Result API 생성 함수
    func submitResult(completion: @escaping () -> Void) {
        guard let galaxyId = appState.currentGalaxyId else {
            print("🚨 galaxyId 없음")
            return
        }

        let request = makeCreateResultRequest()
        print("🚀 회고 생성 요청 시작: \(request)")

        resultService.createResult(galaxyId: galaxyId, request: request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("✅ 회고 생성 성공!")
                    completion()
                    
                case .failure(let error):
                    print("❌ 회고 생성 실패 에러 로그:", error)
                    print("⚠️ 이미 저장된 회고일 가능성이 높으므로 다음 화면으로 진행합니다.")
                    completion()
                }
            }
        }
    }

    
    // MARK: - Result API 조회 함수 (AI 피드백 통합)
    func fetchResult() {
            guard let galaxyId = appState.currentGalaxyId else { return }
            isLoading = true
            
            // 은하 정보
            fetchGalaxyInfo(galaxyId: galaxyId)
            // AI피드백
            fetchAIFeedback(galaxyId: galaxyId)
            
            // 회고 조회
            resultService.checkResult(galaxyId: galaxyId) { [weak self] result in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):

                        guard let data = response.result else {
                            self.fetchOriginalPledges(galaxyId: galaxyId)
                            return
                        }

                        if data.reviewList.isEmpty {
                            self.fetchOriginalPledges(galaxyId: galaxyId)
                        } else {
                            self.isLoading = false
                            self.review = data.reflection
                            self.pledges = data.reviewList.map {
                                PledgeItem(
                                    reviewId: $0.reviewId,
                                    resolutionId: $0.resolutionId,
                                    title: $0.resolutionContent,
                                    content: $0.reviewContent,
                                    status: $0.isResolutionFulfilled ? .success : .fail
                                )
                            }

                            if let matched = self.emojis.first(where: { $0.id == data.reviewEmojiId }) {
                                self.selectedEmojis = [matched]
                            }
                        }

                        
                    case .failure(let error):
                        print("⚠️ 회고 조회 실패 (Decoding Error 가능성): \(error)")
                        self.fetchOriginalPledges(galaxyId: galaxyId)
                    }
                }
            }
        }
        
        // 은하 정보 가져오기
        func fetchGalaxyInfo(galaxyId: Int) {
            galaxyService.checkGalaxy(galaxyId: galaxyId) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.galaxyTitle = data.name
                        self?.travelDate = "\(data.startDate) - \(data.endDate)"
                    case .failure(let error):
                        print("❌ 은하 정보 로드 실패: \(error)")
                    }
                }
            }
        }
        
        // 다짐 & 이모지 가져오기
        func fetchOriginalPledges(galaxyId: Int) {
            pledgeService.getPledge(galaxyId: galaxyId) { [weak self] result in
                guard let self else { return }
                DispatchQueue.main.async {
                    self.isLoading = false
                    switch result {
                    case .success(let response):
                        guard let data = response.result else { return }
                        print("✅ 다짐 로드 완료: \(data.resolutionList.count)개")
                        
                        // 1. 다짐 매핑
                        self.pledges = data.resolutionList.map { res in
                            PledgeItem(
                                reviewId: 0,
                                resolutionId: res.resolutionId ?? 0,
                                title: res.content,
                                content: "",
                                status: .fail
                            )
                        }

                        
                        // 2. [중요] 이모지 매핑 (이게 없어서 회색 원으로 떴던 것!)
                        // data.emojiId는 "happy_emoji" 같은 문자열
                        if let matchedEmoji = self.emojis.first(where: { $0.id == data.emojiId }) {
                            self.selectedEmojis = [matchedEmoji]
                        } else {
                            print("⚠️ 이모지 매칭 실패: \(data.emojiId ?? "nil")")
                        }
                        
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    
    private func createFeedback(galaxyId: Int) {
        feedbackService.createFeedback(galaxyId: galaxyId) { [weak self] result in
            guard let self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("✅ AI 피드백 생성 성공")
                    self.fetchAIFeedback(galaxyId: galaxyId) // 다시 조회

                case .failure(let error):
                    print("❌ 피드백 생성 실패:", error)
                    self.aiFeedback = "AI 피드백 생성에 실패했습니다."
                }
            }
        }
    }

    
    // MARK: - Result API 수정 함수
func patchResult(completion: @escaping () -> Void = {}) {
    guard let galaxyId = appState.currentGalaxyId else { return }

    isLoading = true
    let request = makePatchResultRequest()

    resultService.patchResult(galaxyId: galaxyId, request: request) { [weak self] result in
        guard let self else { return }

        DispatchQueue.main.async {
            switch result {
            case .success:
                self.fetchResult()
                completion()
            case .failure(let error):
                self.isLoading = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

    // MARK: - AI 피드백 조회
    func fetchAIFeedback(galaxyId: Int) {
        feedbackService.fetchFeedback(galaxyId: galaxyId) { [weak self] result in
            guard let self else { return }

            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    if let content = response.result?.content {
                        self.aiFeedback = content
                    } else {
                        self.aiFeedback = "AI 피드백이 아직 생성되지 않았습니다."
                    }

                case .failure(let error):
                    print("❌ AI 피드백 조회 실패:", error)

                    // 🔥 404면 생성
                    if error.localizedDescription.contains("404") {
                        self.createFeedback(galaxyId: galaxyId)
                    } else {
                        self.aiFeedback = "AI 피드백을 불러오지 못했습니다."
                    }
                }
            }
        }
    }


    
    // MARK: - 생성 Mapping
    func makeCreateResultRequest() -> createResultRequest {
        return createResultRequest(
            emojiId: selectedEmoji?.id ?? "happy_emoji",
            reflection: review,
            reviews: pledges.map { item in
                reviewItem(
                    resolutionId: item.resolutionId,
                    reviewContent: item.content,
                    isResolutionFulfilled: item.status == .success
                )
            }
        )
    }

    
    // MARK: - 수정 Mapping
    private func makePatchResultRequest() -> patchResultRequest {
        return patchResultRequest(
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
    @Published var pledges: [PledgeItem] = []
    
    // 여행 후기
    @Published var review: String = ""
    
    // MARK: - 여행 전 다짐 텍스트박스 프로퍼티
    var pledgeCombinedText: String {
        pledges
            .map { "• \($0.title)" }
            .joined(separator: "\n")
    }
    
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
