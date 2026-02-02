import SwiftUI

struct TestView: View {
    let ballCount: Int = 1
    let orbitIndex: Int = 3
    
    // 궤도 반지름 계산
    private var orbitRadius: CGFloat {
        let baseRadius: CGFloat = 40
        let baseGap: CGFloat = 20
        var totalRadius = baseRadius
        for i in 0..<orbitIndex {
            totalRadius += baseGap + CGFloat(i * 8)
        }
        return totalRadius
    }
    
    // 별 크기 계산
    private var starSize: CGFloat { 18 + CGFloat(orbitIndex * 8) }
    
    // 공전 속도 (숫자가 작을수록 빠름)
    private var rotationSpeed: Double { Double(25 - (orbitIndex * 3)) }

    var body: some View {
        // TimelineView는 매초 프레임을 갱신하여 강제로 애니메이션을 만듭니다.
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            // 시간에 따른 현재 회전 각도 계산 (0 ~ 360도 반복)
            let angleOffset = (now.remainder(dividingBy: rotationSpeed) / rotationSpeed) * 360

            ZStack {
                Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
                
                // 궤도 가이드 라인
                Circle()
                    .stroke(Color.white.opacity(0.2), lineWidth: 1.5)
                    .frame(width: orbitRadius * 2, height: orbitRadius * 2)
                
                // 별들 배치
                ForEach(0..<ballCount, id: \.self) { i in
                    // 초기 각도 + 실시간 시간 각도
                    let initialAngle = Double(i) * (360.0 / Double(ballCount))
                    let currentAngle = (initialAngle + angleOffset) * .pi / 180
                    
                    // x, y 좌표 계산
                    let xOffset = cos(currentAngle) * orbitRadius
                    let yOffset = sin(currentAngle) * orbitRadius
                    
                    VStack(spacing: 4) {
                        Circle()
                            .fill(RadialGradient(colors: [.yellow, .orange], center: .center, startRadius: 0, endRadius: starSize/2))
                            .frame(width: starSize, height: starSize)
                        
                        Text("star\(i)")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                        Text("star\(i)")
                            .font(.system(size: 10))
                            .foregroundColor(.white)
                    }
                    // 좌표만 이동 (정면 유지)
                    .offset(x: xOffset, y: yOffset)
                }
            }
        }
    }
}

#Preview {
    TestView()
}


