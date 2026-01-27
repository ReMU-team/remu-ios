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
        ZStack {
            // 궤도 가이드 라인
            Circle()
                .stroke(Color.white, lineWidth: 1.5)
                .frame(width: orbitRadius * 2, height: orbitRadius * 2)
            
            // 해당 궤도의 별들 배치
            ForEach(0..<stars.count, id: \.self) { starIndex in
                let angle = Double(starIndex) * (360.0 / Double(stars.count))
                
                VStack(spacing: 4) {
                    Button(action:{}){
                        Image(stars[starIndex].starIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: starSize, height: starSize)
                            .rotationEffect(.degrees(-rotation - angle)) // 자전 상쇄
                    }
                    Text("\(stars[starIndex].title)")
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6) // 텍스트 좌우 여백 (글자가 길어져도 이 간격은 유지됨)
                        .padding(.vertical, 3)
                        .background(Capsule().fill(Color.white.opacity(0.3)) // 배경색 설정
                            )
                        .rotationEffect(.degrees(-rotation - angle)) // 자전 상쇄
                    
                    Text("Day \(stars[starIndex].onData)")
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(-rotation - angle)) // 자전 상쇄
                    
                }
                .offset(x: orbitRadius)           // 1. 먼저 중심에서 궤도 반지름만큼 밀어냅니다.
                    .rotationEffect(.degrees(angle))  // 2. 궤도 위의 고유 위치(각도)에 배치합니다.
            }
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(.linear(duration: Double(25 - (orbitIndex * 3))).repeatForever(autoreverses: false)) {
                rotation = 360
            }
        }
    }
}
