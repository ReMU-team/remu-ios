//
//  QuestionProvider.swift
//  ReMU
//
//  Created by 원서우 on 2/7/26.
//

import Foundation

enum QuestionIntent {
    case easy
    case deep
}

struct QuestionProvider {

    // MARK: - Public
    static func randomQuestion(intent: QuestionIntent) -> String {
        switch intent {
        case .easy:
            return easyQuestions.randomElement() ?? defaultEasy
        case .deep:
            return deepQuestions.randomElement() ?? defaultDeep
        }
    }

    // MARK: - Easy Questions
    private static let easyQuestions: [String] = [
        "지금 기분을 한 단어로 표현하면?",
        "오늘 날씨는 어땠나요?",
        "지금 가장 먹고 싶은 음식은?",
        "이 순간 가장 먼저 떠오른 생각은?"
    ]

    private static let defaultEasy = "지금 기분을 한 단어로 남겨보세요!"

    // MARK: - Deep Questions
    private static let deepQuestions: [String] = [
        "오늘 가장 기억에 남는 순간은 무엇이었나요?",
        "이번 여행이 나에게 어떤 의미로 남을까요?",
        "오늘의 나는 어떤 감정을 가장 많이 느꼈나요?",
        "이 여행을 시작한 이유를 다시 떠올려본다면?"
    ]

    private static let defaultDeep = "오늘 하루를 돌아보며 가장 인상 깊었던 순간을 적어보세요."
}

