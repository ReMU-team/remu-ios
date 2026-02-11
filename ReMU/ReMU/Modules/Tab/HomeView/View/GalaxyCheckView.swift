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
                HStack{
                    Spacer()
                    Button(action:{}){
                        Text("은하 편집")
                            .font(.pt12)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8) // 텍스트 좌우 여백 (글자가 길어져도 이 간격은 유지됨)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.white.opacity(0.3))
                            ) // 배경색 설정
                    }.padding(.horizontal,22)
                        .padding(.bottom,24)
                }
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 20){
                        ForEach(viewModel.galaxies) { summary in
                            GalaxyCell(
                                galaxyId: summary.galaxyId,
                                title: summary.name,
                                iconName: summary.emojiResourceName
                            )
                            .onTapGesture {
                                appState.currentGalaxyId = summary.galaxyId
                                LastGalaxyStore.save(summary.galaxyId)
                                dismiss()
                            }

                        }
                    }
                }
                .padding(.horizontal, 22)
                Spacer()
                HStack(spacing: 9){
                    PrimaryButton(title: "히스토리", action: {})
                    
                    // 은하 생성 버튼
                    PrimaryButton(title: "은하 생성하기",backgroundColor: .purpleC495E0 , action: {showCreateGalaxy = true})
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
                        onFinish: { _ in
                            Task {
                                await viewModel.fetchGalaxyList()
                            }
                        }
                    )
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



