//
//  StarOrbit.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import SwiftUI

struct DynamicOrbitView: View {
    let stars: [Star]
    let orbitIndex: Int

    @State private var rotation: Double = 0.0

    // 궤도 인덱스에 따른 별 크기
    private var starSize: CGFloat {
        18 + CGFloat(orbitIndex * 8)
    }

    // 궤도 반지름 계산
    private var orbitRadius: CGFloat {
        let baseRadius: CGFloat = 80
        let baseGap: CGFloat = 30
        var totalRadius = baseRadius

        for i in 0..<orbitIndex {
            totalRadius += baseGap + CGFloat(i * 8)
        }
        return totalRadius
    }

    var body: some View {
        ZStack {
            // 궤도 가이드
            Circle()
                .stroke(Color.white, lineWidth: 1.5)
                .frame(width: orbitRadius * 2, height: orbitRadius * 2)

            // ⭐️ 별 배치
            ForEach(stars.indices, id: \.self) { index in
                let star = stars[index]
                let angle = Double(index) * (360.0 / Double(stars.count))

                VStack(spacing: 4) {
                    Button(action: {}) {
                        Image(star.starIcon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: starSize, height: starSize)
                            .rotationEffect(.degrees(-rotation - angle))
                    }

                    Text(star.name)
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 3)
                        .background(
                            Capsule().fill(Color.white.opacity(0.3))
                        )
                        .rotationEffect(.degrees(-rotation - angle))

                    Text("Day \(star.dayOffset)")
                        .font(.system(size: 8))
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(-rotation - angle))
                }
                .offset(x: orbitRadius)
                .rotationEffect(.degrees(angle))
            }
        }
        .rotationEffect(.degrees(rotation))
        .onAppear {
            withAnimation(
                .linear(duration: Double(25 - orbitIndex * 3))
                    .repeatForever(autoreverses: false)
            ) {
                rotation = 360
            }
        }
    }
}
