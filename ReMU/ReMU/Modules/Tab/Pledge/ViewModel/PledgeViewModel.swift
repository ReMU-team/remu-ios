//
//  PledgeViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation
import Combine
import Moya

/// 다짐 작성 화면 전용 ViewModel
/// - 다짐 개수 제한 (1~5)
/// - + / − 버튼 활성화 제어
/// - "다음" 버튼 활성화 판단
/// - Draft -> Card 변환 담당

@MainActor
final class PledgeViewModel: ObservableObject {
    
    @Published var pledgeCard: PledgeCardModel?
    // MARK: - State
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    
    // MARK: - NetwordkService 주입
    private let networkService: NetworkService
    private let provider: MoyaProvider<PledgeTargetType>

    init(networkService: NetworkService) {
        self.networkService = networkService
        self.provider = networkService.createProvider(for: PledgeTargetType.self)
    }
    
    // MARK: - Pledge API 생성 함수
    func createPledge(
        galaxy: Galaxy,
        completion: @escaping (Result<PledgeCardModel, Error>) -> Void
    ) {
        guard let emoji = selectedEmoji else { return }

        let request = CreatePledgeRequest(
            emojiId: emoji.id,
            illustId: "logo_illust_1",
            contents: pledges.map { $0.content }
        )

        provider.request(
            .createPledge(galaxyId: galaxy.serverId, request: request)
        ) { [weak self] result in

            switch result {

            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(
                        CreatePledgeResponse.self,
                        from: response.data
                    )

                    guard let result = decoded.result else { return }

                    let card = self?.makePledgeCard(
                        galaxy: galaxy,
                        result: result
                    )

                    guard let card else {
                        completion(.failure(NSError(domain: "PledgeError", code: -1)))
                        return
                    }

                    completion(.success(card))


                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    // MARK: - Pledge API 조회 함수
    func fetchPledge(galaxy: Galaxy) {
        isLoading = true

        provider.request(.checkPledge(galaxyId: galaxy.serverId)) { [weak self] result in
            guard let self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(
                        CheckPledgeResponse.self,
                        from: response.data
                    )

                    guard let result = decoded.result else { return }

                    self.pledgeCard = self.makePledgeCard(
                        galaxy: galaxy,
                        result: result
                    )

                } catch {
                    self.errorMessage = error.localizedDescription
                }

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }

    
    // MARK: - Pledge API 수정 함수
    func patchPledge(
        galaxyId: Int,
        completion: @escaping (Result<PatchPledgeResponse, Error>) -> Void
    ) {
        guard let emoji = selectedEmoji else { return }

        let request = PatchPledgeRequest(
            emojiId: selectedEmoji?.id,
            resolutions: pledges.map { pledge in
                PatchResolutionItem(
                    resolutionId: pledge.resolutionId,
                    content: pledge.content
                )
            }
        )

        provider.request(
            .patchPledge(galaxyId: galaxyId, request: request)
        ) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(
                        PatchPledgeResponse.self,
                        from: response.data
                    )
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    // MARK: - 생성 Mapping
    private func makePledgeCard(
        galaxy: Galaxy,
        result: CreatePledgeResult
    ) -> PledgeCardModel {

        PledgeCardModel(
            galaxy: galaxy,
            emojiImageName: result.emojiId,
            pledges: result.resolutions.map {
                Pledge(content: $0.content)
            }
        )
    }


    // MARK: - 조회 Mapping
    private func makePledgeCard(
        galaxy: Galaxy,
        result: CheckPledgeResult // 조회
    ) -> PledgeCardModel {
        PledgeCardModel(
            galaxy: galaxy,
            emojiImageName: result.emojiId,
            pledges: result.resolutionList.map {
                Pledge(content: $0.content)
            }
        )
    }

    // MARK: - 수정 Mapping
    private func makePledgeCard(
        galaxy: Galaxy,
        result: PatchPledgeResult // 수정
    ) -> PledgeCardModel {
        PledgeCardModel(
            galaxy: galaxy,
            emojiImageName: result.emojiId,
            pledges: result.contents.map {
                Pledge(content: $0)
            }
        )
    }

    // MARK: - Pledge Count
    let minCount = 1
    let maxCount = 5

    // MARK: - Pledge Drafts
    @Published var pledges: [PledgeDraft] = [
//        PledgeDraft(content: "", example: "예시: 외국인이랑 스몰토킹하기")
    ]

    private let examples = [
        "예시: 외국인이랑 스몰토킹하기",
        "예시: 현지인 맛집 찾아가기",
        "예시: 하루를 한 줄로 기록하기",
        "예시: 사진 한 장은 꼭 남기기",
        "예시: 나에게 선물 하나 사기"
    ]

    // MARK: - Emoji
    let emojis: [EmojiItem] = EmojiCatalog.all

    /// 시트 표시 여부
    @Published var isEmojiSheetPresented = false

    /// 시트 내부 임시 선택 (공용 시트용)
    @Published var tempSelectedEmojis: [EmojiItem] = []

    /// 최종 선택 (이 화면에서는 1개만 사용)
    @Published var selectedEmojis: [EmojiItem] = []

    /// 화면에서 쓰는 단일 이모지
    var selectedEmoji: EmojiItem? {
        selectedEmojis.first
    }

    // MARK: - Button State
    var canAdd: Bool { pledges.count < maxCount }
    var canRemove: Bool { pledges.count > minCount }

    var isNextEnabled: Bool {
        selectedEmoji != nil &&
        pledges.allSatisfy {
            !$0.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }

    // MARK: - Pledge Actions
    func addPledge() {
        guard canAdd else { return }

        let index = pledges.count % examples.count
        pledges.append(
            PledgeDraft(
                resolutionId: nil,
                content: "",
                example: examples[index]
            )
        )
    }

    func removeLastPledge() {
        guard canRemove else { return }
        pledges.removeLast()
    }

    // MARK: - Emoji Sheet Control

    /// 이모지 시트 열기 (기존 선택 복사)
    func openEmojiSheet() {
        tempSelectedEmojis = selectedEmojis
        isEmojiSheetPresented = true
    }

    /// 이모지 선택 확정
    func confirmEmojiSelection() {
        selectedEmojis = tempSelectedEmojis
        isEmojiSheetPresented = false
    }
    
    // MARK: - Preview Card (작성 화면용)
    func makeDraftCard(galaxy: Galaxy) -> PledgeCardModel {
        PledgeCardModel(
            galaxy: galaxy,
            emojiImageName: selectedEmoji?.id ?? "",
            pledges: pledges.map {
                Pledge(content: $0.content)
            }
        )
    }
}
