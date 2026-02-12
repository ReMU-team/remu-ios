////
////  GalaxyMock.swift
////  ReMU
////
////  Created by 김종수 on 1/15/26.
////
//
//import Foundation
//
//  Created by 김종수 on 1/15/26.
//

import Foundation

extension Galaxy {

    static let mock: Galaxy = {

        // MARK: - Date
        let startDate = Calendar.current.date(from: DateComponents(
            year: 2026,
            month: 1,
            day: 15
        ))!

        let endDate = Calendar.current.date(from: DateComponents(
            year: 2026,
            month: 1,
            day: 26
        ))!

        // MARK: - Stars
        let stars: [Star] = (1...12).map { day in
            Star(
                serverId: day,
                name: "Star \(day)",
                dayOffset: day,
                starIcon: "planet_\(day % 8 + 1)"
            )
        }

        // MARK: - Galaxy
        return Galaxy(
            serverId: 1,
            title: "iOS의 개발 여정",
            destination: "서울",
            startDate: startDate,
            endDate: endDate,
            totalDay: 12,
            galaxyIcon: "galaxy_1",
            dDay: 1,
            stars: stars
        )
    }()
}


//extension Galaxy {
//    static let mock: Galaxy = Galaxy(
//        serverId: 1,
//        title: "iOS의 개발 여정",
//        destination: "서울",
//        startDate: DateComponents(
//            calendar: .current,
//            year: 2026,
//            month: 1,
//            day: 15,
//            galaxyIcon: "galaxy_1",
//            stars: [
//                StarData(title: "Star1", onData: 1, starIcon: "planet_1"),
//                StarData(title: "Star2", onData: 2, starIcon: "planet_2"),
//                StarData(title: "Star3", onData: 3, starIcon: "planet_3"),
//                StarData(title: "Star4", onData: 4, starIcon: "planet_4"),
//                StarData(title: "Star5", onData: 5, starIcon: "planet_5"),
//                StarData(title: "Star6", onData: 6, starIcon: "planet_6"),
//                StarData(title: "Star7", onData: 7, starIcon: "planet_7"),
//                StarData(title: "Star8", onData: 8, starIcon: "planet_8"),
//                StarData(title: "Star9", onData: 9, starIcon: "planet_1"),
//                StarData(title: "Star10", onData: 10, starIcon: "planet_2"),
//                StarData(title: "Star11", onData: 11, starIcon: "planet_3"),
//                StarData(title: "Star12", onData: 12, starIcon: "planet_4"),
//                StarData(title: "Star6", onData: 6, starIcon: "planet_6"),
//                StarData(title: "Star7", onData: 7, starIcon: "planet_7"),
//                StarData(title: "Star8", onData: 8, starIcon: "planet_8"),
//                StarData(title: "Star9", onData: 9, starIcon: "planet_1"),
//                StarData(title: "Star10", onData: 10, starIcon: "planet_2"),
//                StarData(title: "Star11", onData: 11, starIcon: "planet_3"),
//                StarData(title: "Star12", onData: 12, starIcon: "planet_4")
//            ]
//        )
//}
