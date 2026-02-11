//
//  ProfileViewModel.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import Foundation
import Combine
import Moya

@MainActor
final class ProfileViewModel: ObservableObject {
    
    // MARK: - Network
    private let provider: MoyaProvider<UserTargetType>
    
    init(networkService: NetworkService) {
            self.provider = networkService.createProvider(for: UserTargetType.self)
        }
    
    // MARK: - Input
    @Published var username: String = ""
    @Published var description: String = ""
    @Published var selectedImageData: Data? = nil
    
    // MARK: - UI State
    @Published var nicknameMessage: String? = nil
    @Published var isNicknameValid: Bool = false
    @Published var isCheckingNickname: Bool = false
    
    // MARK: - Constants
    private let forbiddenNicknames: Set<String> = [
        "remu", "레무", "관리자", "admin"
    ]
    
    // MARK: - Computed
    
    /// 프로필 사진 선택 여부
    var isProfileImageSelected: Bool {
        selectedImageData != nil
    }
    
    /// 시작하기 버튼 활성화 조건
    var isFinishEnabled: Bool {
        isNicknameValid
    }
    
    // MARK: - Nickname Validate + Duplicate Check (단일 함수)

        func validateNickname() async {
            let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)

            // 1. 로컬 검증
            if trimmed.contains(" ") {
                setInvalid("공백은 사용할 수 없어요")
                return
            }

            if trimmed.count < 2 || trimmed.count > 15 {
                setInvalid("2~15자로 입력해주세요")
                return
            }

            let regex = "^[가-힣a-zA-Z0-9]{2,12}$"
            if trimmed.range(of: regex, options: .regularExpression) == nil {
                setInvalid("한글, 영문, 숫자만 사용 가능해요")
                return
            }

            if forbiddenNicknames.contains(trimmed.lowercased()) {
                setInvalid("사용할 수 없는 닉네임이에요")
                return
            }

            // 2. 서버 중복 체크
            isCheckingNickname = true
            nicknameMessage = "닉네임 확인 중..."

            do {
                let response = try await provider.requestAsync(
                    .verifyDuplicateName(name: trimmed)
                )

                let decoded = try response.map(checkDuplicateResponse.self)

                if decoded.available {
                    nicknameMessage = "사용 가능한 닉네임이에요"
                    isNicknameValid = true
                } else {
                    nicknameMessage = decoded.message
                    isNicknameValid = false
                }

            } catch {
                setInvalid("닉네임 확인에 실패했어요")
            }

            isCheckingNickname = false
        }

        private func setInvalid(_ message: String) {
            nicknameMessage = message
            isNicknameValid = false
        }
    
    // MARK: - 프로필 생성 & 수정
    func updateProfile() async -> Bool {
        let request = PatchUserRequest(
                name: username,
                introduction: description.isEmpty ? nil : description,
                imageData: selectedImageData
            )

            do {
                let response = try await provider.requestAsync(.patchUser(request: request))
                let decoded = try response.map(BaseResponse<UserProfileResponse>.self)
                return decoded.isSuccess
            } catch {
                print("프로필 생성/수정 실패", error)
                return false
            }
        }
}












