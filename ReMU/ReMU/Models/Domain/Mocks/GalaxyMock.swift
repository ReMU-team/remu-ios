//
//  GalaxyMock.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation

extension Galaxy {

    static let mock: Galaxy = Galaxy(
        serverId: 1,
        title: "iOS의 개발 여정",
        destination: "서울",
        startDate: DateComponents(
            calendar: .current,
            year: 2026,
            month: 1,
            day: 15
        ).date!,
        endDate: DateComponents(
            calendar: .current,
            year: 2026,
            month: 1,
            day: 22
        ).date!,
        totalDay: 8, 
        galaxyIcon: "galaxy_1",
        stars: [
            Star(serverId: 1, name: "Star 1", dayOffset: 1, starIcon: "planet_1"),
            Star(serverId: 2, name: "Star 2", dayOffset: 2, starIcon: "planet_2"),
            Star(serverId: 3, name: "Star 3", dayOffset: 3, starIcon: "planet_3"),
            Star(serverId: 4, name: "Star 4", dayOffset: 4, starIcon: "planet_4"),
            Star(serverId: 5, name: "Star 5", dayOffset: 5, starIcon: "planet_5"),
            Star(serverId: 6, name: "Star 6", dayOffset: 6, starIcon: "planet_6"),
            Star(serverId: 7, name: "Star 7", dayOffset: 7, starIcon: "planet_7"),
            Star(serverId: 8, name: "Star 8", dayOffset: 8, starIcon: "planet_8")
        ]
    )
}
