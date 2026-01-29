//
//  StarOrbit.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI


struct DynamicOrbitView: View {
    let stars: [StarData]
    let orbitIndex: Int
    
    @State private var rotation: Double = 0.0
    
    // 알고리즘: 궤도 인덱스에 따라 별 크기와 반지름 계산
    private var starSize: CGFloat { 18 + CGFloat(orbitIndex * 8) }
    private var rotationSpeed: Double { Double(25 - (orbitIndex * 3)) }
    
    private var orbitRadius: CGFloat {
        let baseRadius: CGFloat = 80
        let baseGap: CGFloat = 30
        var totalRadius = baseRadius
        // 궤도 사이의 거리가 8씩 누적 증가하는 로직
        for i in 0..<orbitIndex {
            totalRadius += baseGap + CGFloat(i * 8)
        }
        return totalRadius
    }

    var body: some View {
        
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            // 시간에 따른 현재 회전 각도 계산 (0 ~ 360도 반복)
            let angleOffset = (now.remainder(dividingBy: rotationSpeed) / rotationSpeed) * 360
            
            ZStack {
                // 궤도 가이드 라인
                Circle()
                    .stroke(Color.white, lineWidth: 1.5)
                    .frame(width: orbitRadius * 2, height: orbitRadius * 2)
                
                // 해당 궤도의 별들 배치
                ForEach(0..<stars.count, id: \.self) { starIndex in
                    let initialAngle = Double(starIndex) * (360.0 / Double(stars.count))
                    let currentAngle = (initialAngle + angleOffset) * .pi / 180
                    
                    // x, y 좌표 계산
                    let xOffset = cos(currentAngle) * orbitRadius
                    let yOffset = sin(currentAngle) * orbitRadius
                    
                    VStack(spacing: 2) {
                        Button(action:{}){
                            Image(stars[starIndex].starIcon)
                                .resizable()
                                .scaledToFit()
                                .frame(width: starSize, height: starSize)
                        }
                        Text(stars[starIndex].title)
                            .padding(.horizontal, 6)
                            .padding(.vertical,3)
                            .font(.system(size: 8))
                            .foregroundColor(.white)
                            .background(Capsule().fill(Color.white.opacity(0.3)))
                        
                        Text("\(stars[starIndex].onData)Day")
                            .font(.system(size: 8))
                            .foregroundColor(.white)
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
        }
    }
}
