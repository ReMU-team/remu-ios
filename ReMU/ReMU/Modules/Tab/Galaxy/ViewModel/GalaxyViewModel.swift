//
//  GalaxyViewModel.swift
//  ReMU
//
//  Created by 원서우 on 2/1/26.
//

import Foundation

struct GalaxyViewModel {
    let galaxy: Galaxy

    var totalDay: Int {
        Calendar.current.dateComponents(
            [.day],
            from: galaxy.startDate,
            to: galaxy.endDate
        ).day! + 1
    }

    var startMonth: Int {
        Calendar.current.component(.month, from: galaxy.startDate)
    }

    var startDay: Int {
        Calendar.current.component(.day, from: galaxy.startDate)
    }
}
