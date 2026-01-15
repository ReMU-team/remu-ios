//
//  GalaxyMock.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation

struct GalaxyData: Identifiable {
    let id = UUID()
    let title: String
    let totalDay: Int
    let month: Int
    let day: Int
    let galaxyIcon: String
    let stars: [StarData]
}

struct StarData: Identifiable {
    let id = UUID()
    let title: String
    let onData: Int
    let starIcon: String
}

extension GalaxyData {
    static var mock: GalaxyData {
        GalaxyData(
            title: "iOS의 개발 여정",
            totalDay: 3,
            month: 1,
            day: 15,
            galaxyIcon: "galaxy.icon.1",
            stars: [
                StarData(title: "Star1", onData: 1, starIcon: "planet1"),
                StarData(title: "Star2", onData: 2, starIcon: "planet2"),
                StarData(title: "Star3", onData: 3, starIcon: "planet3"),
                StarData(title: "Star4", onData: 4, starIcon: "planet4"),
                StarData(title: "Star5", onData: 5, starIcon: "planet5"),
                StarData(title: "Star6", onData: 6, starIcon: "planet6"),
                StarData(title: "Star7", onData: 7, starIcon: "planet7"),
                StarData(title: "Star8", onData: 8, starIcon: "planet8")
            ]
        )
    }
}

