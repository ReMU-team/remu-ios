//
//  testView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct HomeGalaxyView: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appState: AppState
    
    @StateObject private var viewModel: HomeViewModel

    init(container: DIContainer) {
        _viewModel = StateObject(
            wrappedValue: HomeViewModel(container: container)
        )
    }
    
    // 카드 오버레이
    @State private var showCardOverlay = false
    @State private var selectedCardTab: CardTab = .pledge
    
    
    //네비게이션
    @State private var showCreateGalaxy = false
    @State private var showWriteRecord = false
    @State private var showMenu = false
    @State private var showTimeLine = false
    @State private var showGalaxyList = false
    @State private var showWriteResult = false
    @State private var showCreateResultCard = false
        
    // MARK: - body
    var body: some View {
        ZStack {
            VStack {
                if viewModel.isLoading {
                        ProgressView()
                    } else if appState.currentGalaxy == nil {
                        initialHomeView
                            .transition(.opacity)
                    } else {
                        GalaxyView
                    }
            }
            .allowsHitTesting(!showCardOverlay)
            
            // 카드 오버레이
            if showCardOverlay {
                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation {
                            showCardOverlay = false
                        }
                    }
                    .zIndex(1)
            }
            
            // 기록 카드 오버레이 띄우기
            if viewModel.isShowingRecordCard,
               let model = viewModel.selectedRecordCard {

                Color.black.opacity(0.5)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.isShowingRecordCard = false
                    }

                RecordCardFlip(model: model)
                    .zIndex(10)
            }

            // 다짐/회고 오버레이 띄우기
            if showCardOverlay {
                CardOverlayView(
                    selectedTab: $selectedCardTab,
                    onClose: {
                        withAnimation {
                            showCardOverlay = false
                        }
                    },
                    onWriteResult: {
                        showCardOverlay = false
                        showWriteResult = true
                    }
                )

                .zIndex(2)
            }

        }
        .onAppear {
            syncHomeWithCurrentGalaxy()
        }
        .onChange(of: appState.currentGalaxy?.serverId) { _ in
            syncHomeWithCurrentGalaxy()
        }
        .fullScreenCover(isPresented: $showCreateGalaxy) {
            // 은하 정보 저장
            CreateGalaxyView(
                viewModel: CreateGalaxyViewModel(container: container),
                onFinish: { galaxy in
                    appState.currentGalaxy = galaxy
                    showCreateGalaxy = false
                }
            )
        }
        .fullScreenCover(isPresented: $showTimeLine) {
            TimeLineView()
        }
        .fullScreenCover(isPresented: $showMenu) {
            MenuView(container: container)
        }
        .fullScreenCover(isPresented: $showGalaxyList) {
            GalaxyCheckView(container: container)
                .environmentObject(container)
        }
        .fullScreenCover(isPresented: $showWriteRecord) {
            NavigationStack {
                if let galaxy = viewModel.galaxyData {
                    WriteRecordView(
                        galaxyId: galaxy.serverId,
                        dday: galaxy.totalDay,
                        onFinish: {
                            showWriteRecord = false
                        }
                    )
                }
            }
        }
        .fullScreenCover(isPresented: $showWriteResult) {
            WriteResultView(
                onFinish: {
                    showWriteResult = false
                    showCreateResultCard = true
                }
            )
        }
        .fullScreenCover(isPresented: $showCreateResultCard) {
            CreateResultCardView(
                onFinish: {
                    showCreateResultCard = false
                }
            )
        }



    }
    // MARK: - initialHomeView
    private var initialHomeView: some View {
        GeometryReader { geometry in
            ZStack{
                background
                VStack{
                    upperHeaderUI
                    Spacer()
                    initialHomeButton
                    Spacer()
                }
                .padding(.horizontal, 22)
                // 중요: VStack이 화면 크기를 넘지 않도록 제한
                .frame(width: geometry.size.width, height: geometry.size.height)
            }.ignoresSafeArea()
        }
    }
    
    // MARK: - syncHomeWithCurrentGalaxy
    private func syncHomeWithCurrentGalaxy() {
        Task {
            if let galaxy = appState.currentGalaxy {
                await viewModel.loadHome(galaxyId: galaxy.serverId)
            } else {
                viewModel.clear()
            }
        }
    }

    // MARK: - GalaxyView
    private var GalaxyView: some View {
        // 전체를 감싸는 GeometryReader를 사용해 화면의 실제 크기를 확보합니다.
        GeometryReader { geometry in
            ZStack {
                // 1. 배경 및 은하 레이어 (화면 크기에 딱 맞게 가둠)
                ZStack {
                    background
                    
                    if let data = viewModel.galaxyData {
                        GalaxySystemView(
                            galaxy: data,
                            partitionedStars: viewModel.partitionedStars,
                            scale: viewModel.scale,
                            onSelectStar: viewModel.onSelectStar
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    }
                    
                    
                    
                }
                .contentShape(Rectangle())
                .gesture(MagnificationGesture()
                    .onChanged { value in viewModel.updateScale(magnitude: value.magnitude)
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
    
    // MARK: - background
    private var background: some View{
        ZStack {
            // 배경 색
            Color.blue212148
                .ignoresSafeArea()
            
            // 배경 그라데이션
            GeometryReader { geometry in
                Image("gradation")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(1.4)
                    .offset(x: -100, y: -100)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea() // 배경은 전체에 깔리게
            .allowsHitTesting(false) // 터치 방해 금지
            
            
            // 배경 별
            Image("starObjet")
                .resizable()
                .scaledToFit()
                .allowsHitTesting(false)
        }
    }
    
    // MARK: - upperHeaderUI
    // 코드 가독성을 위해 View를 변수로 분리
    private var upperHeaderUI: some View {
        VStack {
            HStack {
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
            .foregroundColor(.white)
        }
        .padding(.top, 16)
    }
    
    // MARK: - TitleUI
    private var TitleUI: some View {
        VStack(spacing: 8) {
            HStack(spacing: 4) {
                Text(viewModel.galaxyData?.title ?? "Loading...")
                    .font(.system(size: 24)) // .pt24 대신 예시
                Button (action: {showGalaxyList = true}) {
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
        .padding(.top, 40)
    }
    
    // MARK: - initialHomeButton
    private var initialHomeButton: some View {
        VStack(spacing: 0) { // 내부 요소들을 수직으로 묶어줍니다.
            Button (action: {showCreateGalaxy = true}) {
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
    
    // MARK: - bottomAddButton
    private var bottomAddButton: some View {
        Button (action: {showWriteRecord = true}) {
            ZStack {
                Circle()
                    .foregroundColor(.white.opacity(0.3))
                    .frame(width: 54, height: 54)
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(.white)
            }
            // 리퀴드 글래스 효과 적용
            .glassEffect(.clear.interactive(), in: .capsule)
        }
    }
    
    // MARK: - CardButton
    private var CardButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(
                    action: {
                        withAnimation(.easeOut) {
                            showCardOverlay = true
                            selectedCardTab = .pledge
                        }
                    },
                    label: {
                        Image("card")
                            .shadow(color: .white, radius: 5, x: 2, y: 4)
                    }
                )
                .padding(.trailing, 22)
                .padding(.bottom, 20)

            }
        }
    }
}

#Preview {
    let container = DIContainer.preview
    let appState = AppState()

    HomeGalaxyView(container: container)
        .environmentObject(container)
        .environmentObject(appState)
}


