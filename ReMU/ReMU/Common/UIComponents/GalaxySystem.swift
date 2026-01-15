//
//  GalaxySystem.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

import SwiftUI

struct GalaxySystemView: View {
    let galaxyData: GalaxyData
    let partitionedStars: [[StarData]]
    let scale: CGFloat // 확대/축소 배율을 주입받습니다.
    
    var body: some View {
        ZStack {
            // 레이어 1: 궤도 및 별 (줌 영향을 받음)
            ZStack {
                ForEach(0..<partitionedStars.count, id: \.self) { index in
                    DynamicOrbitView(
                        stars: partitionedStars[index],
                        orbitIndex: index
                    )
                }
            }
            .scaleEffect(scale) // 궤도 레이어에만 줌 적용
            
            // 레이어 2: 중앙 메인 행성 (줌 영향을 받지 않음)
            VStack {
                Image(galaxyData.galaxyIcon)
                    .resizable()
                    .frame(width: 109, height: 109)
            }
            // 중앙 아이콘은 scaleEffect를 적용하지 않아 고정됨
        }
    }
}
