//
//  GalaxyCheckView.swift
//  ReMU
//
//  Created by 김종수 on 1/23/26.
//

import SwiftUI

struct GalaxyCheckView: View {
    
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    @State private var showCreateGalaxy = false
    @State private var isEditing = false
    @State private var selectedGalaxy: GalaxySummary?
    
    @StateObject private var viewModel: GalaxyCheckViewModel
    
    init(container: DIContainer) {
        _viewModel = StateObject(
            wrappedValue: GalaxyCheckViewModel(container: container)
        )
    }
    
    private let columns = Array(
        repeating: GridItem(.flexible()),
        count: 4
    )
    
    var body: some View {
        ZStack {
            Color.blue212148.ignoresSafeArea()
            
            GeometryReader { geometry in
                Image("gradation")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(1.4)
                    .offset(x: -100, y: -100)
                    .frame(width: geometry.size.width,
                           height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            
            Image("starObjet")
                .resizable()
                .scaledToFit()
            
            VStack {
                
                // 상단 네비
                HStack {
                    Button { dismiss() } label: {
                        Image("white_left_arrow")
                    }
                    Spacer()
                }
                .padding(22)
                
                Text("나의 우주")
                    .font(.pt24)
                    .foregroundColor(.white)
                    .padding(.bottom, 31)
                
                // 편집 버튼 영역 (높이 고정해서 흔들림 방지)
                HStack {
                    Spacer()
                    
                    if !isEditing {
                        Button {
                            withAnimation {
                                isEditing = true
                            }
                        } label: {
                            Text("은하 편집")
                                .font(.pt12)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(
                                    Capsule()
                                        .fill(Color.white.opacity(0.3))
                                )
                        }
                        .transition(.opacity)
                    }
                }
                .frame(height: 32)   // 자리 고정
                .padding(.horizontal, 22)
                
                // 은하 리스트
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.galaxies) { summary in
                            
                            GalaxyCell(
                                galaxyId: summary.galaxyId,
                                title: summary.name,
                                iconName: summary.emojiResourceName,
                                isEditing: isEditing,
                                onEditTap: {
                                    selectedGalaxy = summary   // edit 진입
                                }
                            )
                            .onTapGesture {
                                if !isEditing {
                                    appState.currentGalaxyId = summary.galaxyId
                                    LastGalaxyStore.save(summary.galaxyId)
                                    dismiss()
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.horizontal, 22)
                
                Spacer()
                
                // 하단 버튼 영역
                HStack(spacing: 9) {
                    if isEditing {
                        PrimaryButton(title: "수정 완료") {
                            withAnimation {
                                isEditing = false
                            }
                        }
                    } else {
                        PrimaryButton(title: "히스토리", action: {})
                        
                        PrimaryButton(
                            title: "은하 생성하기",
                            backgroundColor: .purpleC495E0
                        ) {
                            showCreateGalaxy = true
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchGalaxyList()
            }
        }
        
        // 생성 화면
        .fullScreenCover(isPresented: $showCreateGalaxy) {
            CreateGalaxyView(
                viewModel: CreateGalaxyViewModel(container: container),
                mode: .create,
                onFinish: { createdGalaxyId in
                    appState.currentGalaxyId = createdGalaxyId
                    LastGalaxyStore.save(createdGalaxyId)
                    showCreateGalaxy = false
                }
                
            )
        }
        
        
        // 수정 화면
        .fullScreenCover(item: $selectedGalaxy) { galaxy in
            CreateGalaxyView(
                viewModel: {
                    let vm = CreateGalaxyViewModel(container: container)
                    vm.editingGalaxyId = galaxy.galaxyId
                    return vm
                }(),
                mode: .edit(galaxyId: galaxy.galaxyId),
                onFinish: { _ in
                    
                    // 먼저 화면 닫기
                    selectedGalaxy = nil
                    
                    // 화면 완전히 닫힌 후 리스트 재조회
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        Task {
                            await viewModel.fetchGalaxyList()
                            
                            if galaxy.galaxyId == appState.currentGalaxyId {
                                await homeViewModel.loadHome(galaxyId: galaxy.galaxyId)
                            }
                        }
                    }
                },
                onDelete: {
                    Task {
                        await viewModel.fetchGalaxyList()
                        
                        if appState.currentGalaxyId == galaxy.galaxyId {
                            if let first = viewModel.galaxies.first {
                                appState.currentGalaxyId = first.galaxyId
                                LastGalaxyStore.save(first.galaxyId)
                            } else {
                                appState.currentGalaxyId = nil
                            }
                        }
                    }
                    selectedGalaxy = nil
                }
            )
        }
    }
}

#Preview {
    let container = DIContainer.preview
    let appState = AppState()

    GalaxyCheckView(container: container)
        .environmentObject(container)
        .environmentObject(appState)
}



