//
//  testView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct HomeGalaxyView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        if viewModel.galaxyData == nil {
            initialHomeView
                .transition(.opacity)
        }
        else {
            GalaxyView
        }
        
       
    }
    private var initialHomeView: some View {
        GeometryReader { geometry in
            ZStack{
                background
                VStack{
                    upperHeaderUI
                    Spacer()
                    initialHomeButton
                    Spacer()
                }.padding(.horizontal, 22)
                // 중요: VStack이 화면 크기를 넘지 않도록 제한
                .frame(width: geometry.size.width, height: geometry.size.height)
            }.ignoresSafeArea()
        }
    }
    
    private var GalaxyView: some View {
        // 전체를 감싸는 GeometryReader를 사용해 화면의 실제 크기를 확보합니다.
        GeometryReader { geometry in
            ZStack {
                // 1. 배경 및 은하 레이어 (화면 크기에 딱 맞게 가둠)
                ZStack {
                    background

                    if let data = viewModel.galaxyData {
                        GalaxySystemView(
                            galaxyData: data,
                            partitionedStars: viewModel.partitionedStars,
                            scale: viewModel.scale
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)

                    }
                }.contentShape(Rectangle())                   .gesture(MagnificationGesture().onChanged { value in viewModel.updateScale(magnitude: value.magnitude)
                })
                .ignoresSafeArea() // 배경 레이어만 SafeArea 무시

                // 2. 상단/하단 UI 레이어 (SafeArea 내부 고정)
                VStack {
                    // 상단 헤더
                    upperHeaderUI
                    
                    // 타이틀
                    TitleUI
                    
                    Spacer() // 중간 영역 비움
                    
                    // 하단 플러스 버튼
                    bottomAddButton
                }
                .padding(.horizontal, 22)
                // 중요: VStack이 화면 크기를 넘지 않도록 제한
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
            // 3. 우측 하단 카드 버튼 (별도 배치)
            .overlay(CardButton)
        }
    }
    private var background: some View{
        GeometryReader { geometry in
            Color.blue212148
            
            Image("Homegradation")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.height) // 화면 크기로 고정
                .clipped() // 범위를 벗어나는 이미지 부분은 잘라냄
            
            Image("starObjet")
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width)
        }
    }
    // 코드 가독성을 위해 View를 변수로 분리
    private var upperHeaderUI: some View {
        VStack(spacing: 8) {
            HStack {
                Spacer()
                Button(action: {}) {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                Button(action: {}) {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
            }
            .padding(.bottom, 27)
            .foregroundColor(.white)
    
        }
    }
    private var TitleUI: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Text(viewModel.galaxyData?.title ?? "Loading...")
                    .font(.system(size: 24)) // .pt24 대신 예시
                Button(action: {}) {
                    Image(systemName: "greaterthan")
                        .padding(.leading, 7)
                }
            }
            .foregroundColor(.white)

            if let data = viewModel.galaxyData {
                Text("Day \(data.totalDay) | \(data.month)월 \(data.day)일")
                    .font(.system(size: 16)) // .pt16 대신 예시
                    .foregroundColor(.white)
            }
        }
    }
    private var initialHomeButton: some View {
        VStack(spacing: 0) { // 내부 요소들을 수직으로 묶어줍니다.
            Button(action: {
                // 버튼 클릭 시 동작
            }) {
                ZStack {
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                        .frame(width: 109, height: 109)
                    
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                .foregroundColor(.white) // ZStack 내부의 색상을 결정
            }
            .padding(.bottom, 16) // Button 하단에 여백 추가 (정상 작동)

            Text("첫 은하 생성하기")
                .font(.pt18)
                .foregroundColor(.white)
        }
    }

    private var bottomAddButton: some View {
        Button(action: {}) {
            ZStack {
                Circle()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 54, height: 54)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
            }
        }
    }
    private var CardButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {}) {
                    Image("card")
                        .shadow(color: .white, radius: 5, x: 2, y: 4)
                }
                .padding(.trailing, 22)
                .padding(.bottom, 20)
            }
        }
    }
}
#Preview {
    HomeGalaxyView()
}
