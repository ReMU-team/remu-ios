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
        imageName: "onboarding_1",
        title: "여행, 그냥 지나치기엔 아쉬울 때",
        description: "소중했던 작은 순간들조차 놓치고 싶지 않을 때"
    ),
    OnboardingPage(
        imageName: "onboarding_2",
        title: "사진만으로는 부족할 때",
        description: "여행 중, 사진과 감정을 선해 별을 만들고 기록해요"
    ),
    OnboardingPage(
        imageName: "onboarding_3",
        title: "여행의 처음부터 끝까지",
        description: "여행 흐름 기록하기\n다짐 카드로 시작하고 회고 카드로 마무리해요"
    ),
    OnboardingPage(
        imageName: "onboarding_4",
        title: "지금 남기지 않으면, 이 순간은 사라져요",
        description: "당신만의 여정을 시작해보세요"
    )
]
