//
//  GalaxySystem.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct GalaxySystemView: View {

    static func == (lhs: GalaxySystemView, rhs: GalaxySystemView) -> Bool {
        lhs.galaxy.serverId == rhs.galaxy.serverId &&
        lhs.galaxy.galaxyIcon == rhs.galaxy.galaxyIcon &&
        lhs.partitionedStars.count == rhs.partitionedStars.count
    }

    let galaxy: Galaxy
    let partitionedStars: [[Star]]
    let scale: CGFloat
    let onSelectStar: (Int) -> Void

    var body: some View {
        ZStack {
            ZStack {
                ForEach(partitionedStars.indices, id: \.self) { index in
                    DynamicOrbitView(
                        stars: partitionedStars[index],
                        orbitIndex: index,
                        onSelectStar: onSelectStar
                    )
                }
            }
            .scaleEffect(scale)

            Image(galaxy.galaxyIcon)
                .resizable()
                .frame(width: 150, height: 150)
        }
    }
}

