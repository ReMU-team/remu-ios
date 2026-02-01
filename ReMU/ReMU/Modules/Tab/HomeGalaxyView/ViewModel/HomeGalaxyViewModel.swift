//
//  HomeGalaxyViewModel.swift
//  ReMU
//
//  Created by 원서우 on 2/1/26.
//

import Foundation
import SwiftUI
import Combine

final class HomeGalaxyViewModel: ObservableObject {

    // MARK: - State
    @Published var galaxy: Galaxy? = nil
    @Published var scale: CGFloat = 1.0

    // MARK: - Derived Data
    var partitionedStars: [[Star]] {
        guard let stars = galaxy?.stars else { return [] }
        return stride(from: 0, to: stars.count, by: 3).map {
            Array(stars[$0..<min($0 + 3, stars.count)])
        }
    }

    // MARK: - Actions
    func updateScale(magnitude: CGFloat) {
        scale = min(max(magnitude, 0.8), 2.0)
    }
}

