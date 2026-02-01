//
//  GalaxySystem.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct GalaxySystemView: View {
    let galaxy: Galaxy
    let partitionedStars: [[Star]]
    let scale: CGFloat

    var body: some View {
        ZStack {
            ZStack {
                ForEach(partitionedStars.indices, id: \.self) { index in
                    DynamicOrbitView(
                        stars: partitionedStars[index],
                        orbitIndex: index
                    )
                }
            }
            .scaleEffect(scale)

            Image(galaxy.galaxyIcon)
                .resizable()
                .frame(width: 109, height: 109)
        }
    }
}
