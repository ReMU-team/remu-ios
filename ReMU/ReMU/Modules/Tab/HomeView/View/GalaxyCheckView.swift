//
//  GalaxyCheckView.swift
//  ReMU
//
//  Created by 김종수 on 1/23/26.
//

import Foundation
import SwiftUI

/// 은하 리스트를 볼 수 있는 뷰입니다.
struct GalaxyCheckView: View {
    
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appState: AppState

    
    // 네비게이션
    @State private var showCreateGalaxy = false
    @State private var isEditing = false
    @State private var selectedGalaxy: GalaxySummary?
    @State private var showEditGalaxy = false

    @StateObject private var viewModel: GalaxyCheckViewModel
    
    init(container: DIContainer) {
        _viewModel = StateObject(
            wrappedValue: GalaxyCheckViewModel(container: container)
        )
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    var body: some View {
        ZStack{
            Color.blue212148.ignoresSafeArea()
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
            Image("starObjet")
                .resizable()
                .scaledToFit()
            VStack{
                HStack{
                    // 뒤로가기
                    Button {
                        dismiss()
                    } label: {
                        Image("white_left_arrow")
                    }
                    
                    Spacer()
                    
                }
                .padding(22)
                .foregroundColor(.white)
                Text("나의 우주")
                    .font(.pt24)
                    .foregroundColor(.white)
                    .padding(.bottom,31)
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
                .frame(height: 32)
                .padding(.horizontal,22)

                ScrollView{
                    LazyVGrid(columns: columns,spacing: 10){
                        ForEach(viewModel.galaxies) { summary in
                            GalaxyCell(
                                galaxyId: summary.galaxyId,
                                title: summary.name,
                                iconName: summary.emojiResourceName,
                                isEditing: isEditing,
                                onEditTap: {
                                    selectedGalaxy = summary
                                    showEditGalaxy = true
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
                HStack(spacing: 9){
                    if isEditing {
                        PrimaryButton(title: "수정 완료") {
                            withAnimation {
                                isEditing = false
                            }
                        }
                    } else {
                        HStack(spacing: 9) {
                            PrimaryButton(title: "히스토리", action: {})
                            PrimaryButton(title: "은하 생성하기", backgroundColor: .purpleC495E0) {
                                showCreateGalaxy = true
                            }
                        }
                    }

                }
                .padding(.horizontal,40)
                .onAppear {
                    Task {
                        await viewModel.fetchGalaxyList()
                    }
                }
                // 은하 생성 뷰로 이동
                .fullScreenCover(isPresented: $showCreateGalaxy) {
                    CreateGalaxyView(
                        viewModel: CreateGalaxyViewModel(container: container),
                        mode: .create,
                        onFinish: {
                            Task {
                                await viewModel.fetchGalaxyList()
                            }
                            showCreateGalaxy = false
                        }
                    )
                }
                .fullScreenCover(isPresented: $showEditGalaxy) {
                    if let galaxy = selectedGalaxy {
                        CreateGalaxyView(
                            viewModel: {
                                let vm = CreateGalaxyViewModel(container: container)
                                vm.editingGalaxyId = galaxy.galaxyId
                                return vm
                            }(),
                            mode: .edit(galaxyId: galaxy.galaxyId),
                            onFinish: {
                                Task {
                                    await viewModel.fetchGalaxyList()
                                }
                                showEditGalaxy = false
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
                                showEditGalaxy = false
                            }
                        )
                    }
                }


            }
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



