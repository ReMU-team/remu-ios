//
//  CreateGalaxyViewModel.swift
//  ReMU
//
//  Created by 김진서 on 1/23/26.
//

import Foundation
import Combine

@MainActor
@Observable
final class CreateGalaxyViewModel: ObservableObject {
    @Published var createdGalaxy: Galaxy?

    
    @Published var destination: String?
    @Published var startDate: Date?
    @Published var endDate: Date?
    
    

    @Published var showPlaceSearch = false
    @Published var showCalendar = false

    var isFinishEnabled: Bool {
        destination != nil &&
        startDate != nil &&
        endDate != nil &&
        !galaxyName.trimmingCharacters(in: .whitespaces).isEmpty &&
        selectedGalaxyImageName != nil
    }
    
//    func makeGalaxy() -> Galaxy {
//        Galaxy(
//            id: UUID(),
//            name: galaxyName,
//            destination: destination!,
//            startDate: startDate,
//            endDate: endDate,
//            imageName: selectedGalaxyImageName!
//        )
//    }
}
