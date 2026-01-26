//
//  CreateGalaxyViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/23/26.
//

import Foundation
import Combine

@MainActor
final class CreateGalaxyViewModel: ObservableObject {

    @Published var destination: String?
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var galaxyName: String = ""
    @Published var selectedGalaxyImageName: String?

    @Published var showPlaceSearch = false
    @Published var showCalendar = false

    var isFinishEnabled: Bool {
        destination != nil &&
        startDate != nil &&
        endDate != nil &&
        !galaxyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGalaxyImageName != nil
    }
}
