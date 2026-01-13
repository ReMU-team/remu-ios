//
//  OnboardingPage.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import Foundation

struct OnboardingPage {
    let imageName: String
    let title: String
    let description: String
}

let onboardingPages: [OnboardingPage] = [
    OnboardingPage(
        imageName: "logo_primary",
        title: "나만의 은하",
        description: "나만의 여행이 은하처럼 펼쳐져요"
    ),
    OnboardingPage(
        imageName: "logo_text",
        title: "레뮤에 대한 설명",
        description: "기록하고, 회고하고"
    ),
    OnboardingPage(
        imageName: "kakao_icon",
        title: "레뮤에 대한 설명",
        description: "여행을 이어가는 나의 다짐"
    ),
    OnboardingPage(
        imageName: "google_icon",
        title: "레뮤에 대한 설명",
        description: "여행의 시작, 당신만의 은하로 떠나요"
    )
]
