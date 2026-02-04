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
    
    // 알고리즘: 궤도 인덱스에 따라 별 크기와 반지름 계산
    private var starSize: CGFloat { 18 + CGFloat(orbitIndex * 8) }
    private var rotationSpeed: Double { Double(30 - (orbitIndex * 2)) }
    
    private var orbitRadius: CGFloat {
        let baseRadius: CGFloat = 75
        let baseGap: CGFloat = 50
        var totalRadius = baseRadius

        // 궤도 사이의 거리가 8씩 누적 증가하는 로직
        for _ in 0..<orbitIndex {
            totalRadius += baseGap
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
                    .stroke(Color.white.opacity(0.63), lineWidth: 1)
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
                        }.overlay(
                            VStack(spacing: 1) {
                                Text(stars[starIndex].title)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical,2)
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                                    .background(Capsule().fill(Color.white.opacity(0.3)))
                                
                                Text("\(stars[starIndex].onData)Day")
                                    .font(.system(size: 8))
                                    .foregroundColor(.white)
                            }
                            .fixedSize() // 텍스트가 길어져도 별의 위치에 영향을 주지 않음
                            .offset(y: starSize / 2 + 15) // 별 중심에서 아래로 밀어내기
                            , alignment: .center
                        )
                    }
                    .offset(x: xOffset, y: yOffset)
                }
            }
        }
    }
}

//let now = timeline.date.timeIntervalSinceReferenceDate
//// 시간에 따른 현재 회전 각도 계산 (0 ~ 360도 반복)
//let angleOffset = (now.remainder(dividingBy: rotationSpeed) / rotationSpeed) * 360
//
//ZStack {
//    Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
//    
//    // 궤도 가이드 라인
//    Circle()
//        .stroke(Color.white.opacity(0.2), lineWidth: 1.5)
//        .frame(width: orbitRadius * 2, height: orbitRadius * 2)
//    
//    // 별들 배치
//    ForEach(0..<ballCount, id: \.self) { i in
//        // 초기 각도 + 실시간 시간 각도
//        let initialAngle = Double(i) * (360.0 / Double(ballCount))
//        let currentAngle = (initialAngle + angleOffset) * .pi / 180
//        
//        // x, y 좌표 계산
//        let xOffset = cos(currentAngle) * orbitRadius
//        let yOffset = sin(currentAngle) * orbitRadius
//        
//        VStack(spacing: 4) {
//            Circle()
//                .fill(RadialGradient(colors: [.yellow, .orange], center: .center, startRadius: 0, endRadius: starSize/2))
//                .frame(width: starSize, height: starSize)
//            
//            Text("star\(i)")
//                .font(.system(size: 10))
//                .foregroundColor(.white)
//            Text("star\(i)")
//                .font(.system(size: 10))
//                .foregroundColor(.white)
//        }
//        // 좌표만 이동 (정면 유지)
//        .offset(x: xOffset, y: yOffset)
