//
//  Galaxy.swift
//  ReMU
//
//  Created by 김진서 on 1/22/26.
//

import Foundation

struct Galaxy: Identifiable, Hashable {
    let id: UUID = UUID() // 로컬 식별 id (UI용)
    let serverId: Int // 서버 식별 id (API용)
    
    let title: String // 은하 이름
    let destination: String // 여행 장소
    let startDate: Date // 여행 시작일
    let endDate: Date // 여행 종료일
    let totalDay: Int // 전체 여행 일 수
    let galaxyIcon: String // 은하 이미지
    
    let stars: [Star] // 은하의 별들
}

extension Galaxy {
    var month: Int {
        Calendar.current.component(.month, from: startDate)
    }

    var day: Int {
        Calendar.current.component(.day, from: startDate)
    }
}

// 별 리스트
struct Star: Hashable {
    let serverId: Int
    let name: String // 별 이름
    let dayOffset: Int // ?일차 (ex.DAY3)
    let starIcon: String // 별 이미지
}
