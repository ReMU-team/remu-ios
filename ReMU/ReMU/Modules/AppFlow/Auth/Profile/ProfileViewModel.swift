//
//  ProfileViewModel.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var username: String = "JongSoo"
    @Published var description: String = "js@example.com"
    @Published var profileImageURL: URL? = nil
    @Published var selectedImageData: Data? = nil
    
    func fetchProfile() {
            // 서버에서 데이터를 받아와서 profileImageUrl 등을 업데이트
        }
        
    // 2. POST/PUT: 수정사항 저장하기
    func updateProfile() {
        if let data = selectedImageData {
            print("새로운 이미지를 서버에 업로드합니다. (MultipartFormData)")
            // API 호출: Multipart로 data 전송
        } else {
            print("이미지는 변경되지 않았습니다. 텍스트 정보만 업데이트합니다.")
        }
    }
}


