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
            galaxyIcon: "galaxy_1",
            stars: [
                StarData(title: "Star1", onData: 1, starIcon: "planet_1"),
                StarData(title: "Star2", onData: 2, starIcon: "planet_2"),
                StarData(title: "Star3", onData: 3, starIcon: "planet_3"),
                StarData(title: "Star4", onData: 4, starIcon: "planet_4"),
                StarData(title: "Star5", onData: 5, starIcon: "planet_5"),
                StarData(title: "Star6", onData: 6, starIcon: "planet_6"),
                StarData(title: "Star7", onData: 7, starIcon: "planet_7"),
                StarData(title: "Star8", onData: 8, starIcon: "planet_8"),
                StarData(title: "Star9", onData: 9, starIcon: "planet_1"),
                StarData(title: "Star10", onData: 10, starIcon: "planet_2"),
                StarData(title: "Star11", onData: 11, starIcon: "planet_3"),
                StarData(title: "Star12", onData: 12, starIcon: "planet_4"),
                StarData(title: "Star6", onData: 6, starIcon: "planet_6"),
                StarData(title: "Star7", onData: 7, starIcon: "planet_7"),
                StarData(title: "Star8", onData: 8, starIcon: "planet_8"),
                StarData(title: "Star9", onData: 9, starIcon: "planet_1"),
                StarData(title: "Star10", onData: 10, starIcon: "planet_2"),
                StarData(title: "Star11", onData: 11, starIcon: "planet_3"),
                StarData(title: "Star12", onData: 12, starIcon: "planet_4")
            ]
        )
    }
}

