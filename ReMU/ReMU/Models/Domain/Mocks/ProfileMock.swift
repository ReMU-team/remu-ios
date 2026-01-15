//
//  ProfileMock.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import PhotosUI

// 1. 실제 앱에서 사용할 도메인
struct Profile: Identifiable {
    let id = UUID()
    let username: String
    let description: String
    let ProfileImage: UIImage? = nil
}

// 2. Mock 데이터는 extension으로 관리
extension Profile {
    static let mock = Profile(
        username: "iOSDev",
        description: "왜 이렇게 어렵지"
    )

}
