//
//  testView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct HomeGalaxyView: View {
    @EnvironmentObject var appState: AppState
    
    @StateObject private var viewModel = HomeViewModel()
    
    //네비게이션
    @State private var showCreateGalaxy = false
    @State private var showWritePledge = false
    @State private var showWriteRecord = false
    @State private var showMenu = false
    @State private var showTimeLine = false
    @State private var showGalaxyList = false
    
    @State private var galaxies: [Galaxy] = []

    var body: some View {
        ZStack {
            // MARK: - 1. 배경 레이어
            Color.blue212148.ignoresSafeArea()
            
            // 배경 그라데이션
            GeometryReader { geometry in
                    Image("gradation")
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.5)
                        .offset(x: -100, y: -100)
                        // 화면 크기를 geometry에서 가져와서 꽉 채우되,
                        // 프레임을 잡고 잘라내어(clipped) 외부 레이아웃에 영향을 주지 않음
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea() // 배경은 전체에 깔리게
                .allowsHitTesting(false) // 터치 방해 금지
            
            Image("starObjet")
                .resizable()
                .scaledToFit()
            
            // MARK: - 2. 메인 은하 시스템 (중앙 배치)
            if let data = viewModel.galaxyData {
                GalaxySystemView(
                    galaxyData: data,
                    partitionedStars: viewModel.partitionedStars,
                    scale: viewModel.scale // 줌 배율 전달
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            viewModel.updateScale(magnitude: value.magnitude)
                        }
                )
            } else {
                ProgressView().tint(.white)
            }
            VStack(alignment: .trailing){
                Spacer()
                HStack{
                    Spacer()
                    
                    // 다짐/회고 카드 조회
                    Button(action:{}){
                        Image("card")
                            .shadow(color: .white ,radius:5, x: 2, y: 4)
                    }
                    .padding(.trailing, 22) // 화면 끝에서 살짝 띄우기
                    .padding(.bottom, 20)   // 하단에서 살짝 띄우기
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // 화면 전체를 차지하게 하여 Spacer가 작동하게 함
            .allowsHitTesting(true) // 하위 버튼 클릭 가능하도록 보장
            
            
            // MARK: - 3. 상단 정보 UI (줌 영향 없이 고정)
            VStack {
                HStack{
                    Spacer()
                    Button(action: {showTimeLine = true}){
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 24,height: 24)
                    }
                    Button(action: {showMenu = true}){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24,height: 24)
                    }
                }
                .padding(.bottom,27)
                .foregroundColor(.white)
                
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text(viewModel.galaxyData?.title ?? "Loading...")
                            .font(.pt24)
                        
                        // 은하 전체 목록 이동
                        Button(action: {showGalaxyList = false}) {
                            Image(systemName: "greaterthan")
                                .padding(.leading,7)
                                
                        }
                        
                    }
                    .foregroundColor(.white)
                    
                    if let data = viewModel.galaxyData {
                        Text("Day \(data.totalDay) | \(data.month)월 \(data.day)일")
                            .font(.pt16)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer() // 텍스트를 상단으로 밀어냄
                
                // 기록 생성 버튼
                Button(action:{showWriteRecord = true}){
                    ZStack{
                        Circle()
                            .foregroundColor(.white.opacity(0.3))
                            .frame(width: 54,height: 54)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18,height: 18)
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal,22)
        }
        .fullScreenCover(isPresented: $showCreateGalaxy) {
            CreateGalaxyView { galaxy in
                    galaxies.append(galaxy)
                }
        }
        .fullScreenCover(isPresented: $showTimeLine) {
            TimeLineView()
        }
        .fullScreenCover(isPresented: $showMenu) {
            MenuView()
        }
        .fullScreenCover(isPresented: $showWritePledge) {
            NavigationStack {
                WritePledgeView(
                    onFinish: {
                        showWritePledge = false
                    }
                )
            }
        }
        .fullScreenCover(isPresented: $showWriteRecord) {
            NavigationStack {
                WriteRecordView(
                    onFinish: {
                        showWriteRecord = false
                    }
                )
            }
        }
        .fullScreenCover(isPresented: $showGalaxyList) {
            NavigationStack {
                GalaxyCheckView(
                    galaxyList: viewModel.galaxyData.map { [$0] } ?? []
                )
            }
            
        }
        .modifier(ActionAlertModifier())
    }
}
#Preview {
    HomeGalaxyView()
}
