//
//  ResultCardMock.swift
//  ReMU
//
//  Created by 원서우 on 2/6/26.
//

import Foundation

extension ResultCard {
    static let mock = ResultCard(
        galaxyServerId: 1,
        pledgeEmojiImageName: "happy_emoji",
        resultEmojiImageName: "sad_emoji",
        reviews: [
            Review(
                id: 1,
                pledgeId: 1,
                pledgeContent: "현지인 맛집 찾아가기",
                reviewContent: "골목에 있는 로컬 맛집을 찾아서 정말 만족스러웠다.",
                isFulfilled: true
            ),
            Review(
                id: 2,
                pledgeId: 2,
                pledgeContent: "사진 한 장은 꼭 남기기",
                reviewContent: "노을이 질 때 사진을 남겼다.",
                isFulfilled: true
            ),
            Review(
                id: 3,
                pledgeId: 3,
                pledgeContent: "하루를 한 줄로 기록하기",
                reviewContent: "매일 밤 하루를 돌아보는 시간이 좋았다.",
                isFulfilled: false
            )
        ],
        reflection: "전체적으로 계획을 잘 지킨 만족스러운 여행이었다.",
        aiFeedback: "계획 대비 실행률이 높고, 감정 기록이 잘 남아있는 여행입니다."
    )
}

