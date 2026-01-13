//
//  GalaxyAnimationView.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import SwiftUI

struct GalaxyAnimationView: View {
    @State private var selectPlanet: Planet? = nil
    
    // 초기 화면에 바로 정보가 보이도록 설정 (선택 사항)
    init() {
        _selectPlanet = State(initialValue: planets[7]) // 해왕성 초기 선택
    }
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            SolarSystemView(selectPlanet: $selectPlanet)
                .scaleEffect(0.4) // 전체 크기 조절
            
            VStack(spacing: 8) {
                if let selected = selectPlanet {
                    Text(selected.name)
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                    Text(selected.description)
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.top, 100)
        }
    }
}

struct SolarSystemView: View {
    @Binding var selectPlanet: Planet?
    
    var body: some View {
        ZStack {
            // 중앙의 태양
            Circle()
                .fill(Color.orange)
                .frame(width: 100, height: 100)
                .shadow(color: .orange, radius: 20)
            
            // 궤도 라인들
            ForEach(0..<planets.count, id: \.self) { index in
                Circle()
                    .stroke(planets[index].color.opacity(1), lineWidth: 0.8)
                    .frame(width: planets[index].orbitRadius * 2, height: planets[index].orbitRadius * 2)
            }
            
            // 행성들
            ForEach(planets, id: \.name) { planet in
                PlanetView(planet: planet, selectPlanet: $selectPlanet)
            }
        }
    }
}

struct PlanetView: View {
    let planet: Planet
    @Binding var selectPlanet: Planet?
    @State private var rotation: Double = 0.0
    
    var body: some View {
        Circle()
            .fill(planet.color)
            .frame(width: planet.size, height: planet.size)
            // 1. 행성을 궤도 반지름만큼 이동
            .offset(x: planet.orbitRadius)
            // 2. 이동한 행성을 중앙 기준으로 회전시킴
            .rotationEffect(.degrees(rotation))
            .onAppear {
                // 무한 반복 애니메이션 설정
                withAnimation(Animation.linear(duration: planet.speed).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
            .onTapGesture {
                selectPlanet = planet
            }
    }
}

// 행성 데이터 구조체 및 샘플 데이터
struct Planet: Equatable, Identifiable {
    var id: String { name }
    var color: Color
    var size: CGFloat
    var orbitRadius: CGFloat
    var speed: Double
    var name: String
    var description: String
}

let planets = [
    Planet(color: .gray, size: 10, orbitRadius: 60, speed: 50, name: "Mercury", description: "Closest to the Sun"),
    Planet(color: .orange, size: 18, orbitRadius: 100, speed: 7, name: "Venus", description: "Earth's hottest twin"),
    Planet(color: .blue, size: 20, orbitRadius: 150, speed: 10, name: "Earth", description: "Our home planet"),
    Planet(color: .red, size: 16, orbitRadius: 200, speed: 12, name: "Mars", description: "The Red Planet"),
    Planet(color: .brown, size: 35, orbitRadius: 280, speed: 20, name: "Jupiter", description: "The largest planet"),
    Planet(color: .yellow, size: 30, orbitRadius: 360, speed: 25, name: "Saturn", description: "The ringed jewel"),
    Planet(color: .cyan, size: 22, orbitRadius: 430, speed: 30, name: "Uranus", description: "The ice giant"),
    Planet(color: .blue, size: 22, orbitRadius: 500, speed: 35, name: "Neptune", description: "Farthest from the Sun")
]

#Preview {
    GalaxyAnimationView()
}
