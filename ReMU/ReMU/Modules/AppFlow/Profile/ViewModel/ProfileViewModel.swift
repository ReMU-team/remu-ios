//
//  ProfileViewModel.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import Foundation
import Combine

//class ProfileViewModel: ObservableObject {
//    @Published var username: String = "아요"
//    @Published var description: String = "여행을 사랑하는 개발자"
//    @Published var profileImageURL: URL? = nil
//    @Published var selectedImageData: Data? = nil
//    
//    func fetchProfile() {
//            // 서버에서 데이터를 받아와서 profileImageUrl 등을 업데이트
//        }
//        
//    // 2. POST/PUT: 수정사항 저장하기
//    func updateProfile() {
//        if let data = selectedImageData {
//            print("새로운 이미지를 서버에 업로드합니다. (MultipartFormData)")
//            // API 호출: Multipart로 data 전송
//        } else {
//            print("이미지는 변경되지 않았습니다. 텍스트 정보만 업데이트합니다.")
//        }
//    }
//}

import Foundation
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {

    // MARK: - Input Values
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

    // MARK: - Computed States

    /// 프로필 사진 선택 여부
    var isProfileImageSelected: Bool {
        selectedImageData != nil
    }

    /// 시작하기 버튼 활성화 조건
    var isFinishEnabled: Bool {
        isNicknameValid
    }

    // MARK: - Nickname Validation

    /// 입력 완료 시 호출
    func validateNickname() {
        let trimmed = username.trimmingCharacters(in: .whitespacesAndNewlines)

        // 공백 포함 불가
        if trimmed.contains(" ") {
            setInvalid("공백은 사용할 수 없어요")
            return
        }

        // 길이 제한
        if trimmed.count < 2 || trimmed.count > 12 {
            setInvalid("2~12자로 입력해주세요")
            return
        }

        // 허용 문자 (한글 / 영문 / 숫자)
        let regex = "^[가-힣a-zA-Z0-9]{2,12}$"
        if trimmed.range(of: regex, options: .regularExpression) == nil {
            setInvalid("한글, 영문, 숫자만 사용 가능해요")
            return
        }

        // 금지 닉네임
        if forbiddenNicknames.contains(trimmed.lowercased()) {
            setInvalid("사용할 수 없는 닉네임이에요")
            return
        }

        // 형식 통과 → 중복 체크
        checkNicknameDuplicate(trimmed)
    }

    private func setInvalid(_ message: String) {
        nicknameMessage = message
        isNicknameValid = false
    }

    // MARK: - Duplicate Check (Mock)

    /// 서버 연동 전 임시 중복 체크
    private func checkNicknameDuplicate(_ nickname: String) {
        isCheckingNickname = true
        nicknameMessage = "닉네임 확인 중..."

        // TODO: 서버 API로 교체
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.isCheckingNickname = false

            let duplicatedNicknames = ["test", "user1", "admin"]
            let isDuplicated = duplicatedNicknames.contains(nickname.lowercased())

            if isDuplicated {
                self.nicknameMessage = "이미 사용중인 닉네임이에요"
                self.isNicknameValid = false
            } else {
                self.nicknameMessage = "사용 가능한 닉네임이에요"
                self.isNicknameValid = true
            }
        }
    }

    // MARK: - Profile Save

    func updateProfile() {
        guard isFinishEnabled else { return }

        if let imageData = selectedImageData {
            print("프로필 이미지 업로드 (Multipart)")
            // TODO: 이미지 업로드 API
        }

        print("닉네임:", username)
        print("소개:", description)
        print("프로필 저장 완료")
    }
}


