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
    
    // MARK: - Network Service
    init(
        appState: AppState,
        resultService: ResultServiceProtocol,
        pledgeService: PledgeServiceProtocol,
        galaxyService: GalaxyServiceProtocol
    ) {
        self.appState = appState
        self.resultService = resultService
        self.pledgeService = pledgeService
        self.galaxyService = galaxyService
    }

    // MARK: - Result API 생성 함수
    func submitResult(completion: @escaping () -> Void) {
        guard let galaxyId = appState.currentGalaxyId else {
            print("🚨 galaxyId 없음")
            return
        }

        let request = makeCreateResultRequest()

        // 요청 데이터가 올바른지 로그로 확인
        print("🚀 회고 생성 요청 시작: \(request)")

        resultService.createResult(
            galaxyId: galaxyId,
            request: request
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    print("✅ 회고 생성 성공!")
                    completion()
                case .failure(let error):
                    // 여기서 에러가 찍히고 있을 겁니다.
                    print("❌ 회고 생성 실패 에러 로그:", error)
                    self.errorMessage = "회고 생성 실패: \(error.localizedDescription)"
                }
            }
        }
    }

    
    // MARK: - Result API 조회 함수 (AI 피드백 통합)
    func fetchResult() {
            guard let galaxyId = appState.currentGalaxyId else { return }
            isLoading = true
            
            // 1. 은하 정보(제목, 날짜) 먼저 가져오기 (Review API가 빈값일 때를 대비)
            fetchGalaxyInfo(galaxyId: galaxyId)
            
            // 2. 회고 조회
            resultService.checkResult(galaxyId: galaxyId) { [weak self] result in
                guard let self else { return }
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        // 회고가 비어있으면 -> 다짐 불러오기
                        if response.reviews.isEmpty {
                            print("ℹ️ 회고 없음. 다짐 불러오기 시작")
                            self.fetchOriginalPledges(galaxyId: galaxyId)
                        } else {
                            print("✅ 회고 로드 성공")
                            self.isLoading = false
                            // 기존 로직 유지 (response.galaxyTitle이 Optional이면 ?? "" 처리)
                            self.galaxyTitle = response.galaxyTitle ?? self.galaxyTitle
                            self.travelDate = response.travelDate ?? self.travelDate
                            self.reviewResult = self.makeReviewResult(from: response)
                            self.aiFeedback = response.aiFeedback
                            self.pledges = self.mapReviewsToPledges(from: response)
                            
                            // 이모지 매칭
                            if let matched = self.emojis.first(where: { $0.id == response.travelEmojiImageName }) {
                                self.selectedEmojis = [matched]
                            }
                        }
                        
                    case .failure(let error):
                        print("⚠️ 회고 조회 실패 (Decoding Error 가능성): \(error)")
                        // Decoding Error가 나더라도, 아직 작성을 안 해서 그런 것일 수 있으므로
                        // 강제로 다짐을 불러오도록 처리합니다.
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
                                reviewId: res.resolutionId ?? 0,
                                title: res.content,
                                content: "",
                                status: .fail
                            )
                        }
                        
                        // 2. [중요] 이모지 매핑 (이게 없어서 회색 원으로 떴던 것!)
                        // data.emojiId는 "happy_emoji" 같은 문자열입니다.
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

    
    // MARK: - 생성 Mapping
    func makeCreateResultRequest() -> createResultRequest {
        return createResultRequest(
            emojiId: selectedEmoji?.id ?? "happy_emoji",
            reflection: review,
            reviews: pledges.map { item in
                reviewItem(
                    resolutionId: item.reviewId,
                    reviewContent: item.content,
                    isResolutionFulfilled: item.status == .success
                )
            }
        )
    }
    
    // MARK: - 조회 Mapping
    private func makeReviewResult(from response: CheckResultResponse) -> ReviewResult {
        return ReviewResult(
            galaxyId: response.galaxyId,
            travelEmojiImageName: response.travelEmojiImageName ?? "",
            overallContent: response.overallContent ?? "",
            hasAIFeedback: response.aiFeedback != nil
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

    
    private func mapReviewsToPledges(from response: CheckResultResponse) -> [PledgeItem] {
        response.reviews.map {
            PledgeItem(
                reviewId: $0.reviewId,
                title: $0.title,
                content: $0.content,
                status: $0.isResolutionFulfilled ? .success : .fail
            )
        }
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
