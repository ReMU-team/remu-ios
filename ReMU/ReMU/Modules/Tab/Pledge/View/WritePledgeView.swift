//
//  WritePledgeView.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import SwiftUI

struct WritePledgeView: View {
    let galaxy: Galaxy
    let mode: PledgeMode
    let existingCard: PledgeCardModel?
    let onFinish: () -> Void
    
    // 네비게이션 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 뷰모델 연결
    @StateObject private var viewModel: PledgeViewModel
    
    // 다음 버튼
    @State private var goNext = false
    
    init(
        galaxy: Galaxy,
        container: DIContainer,
        mode: PledgeMode = .create,
        existingCard: PledgeCardModel? = nil,
        onFinish: @escaping () -> Void
    ) {
        self.galaxy = galaxy
        self.mode = mode
        self.existingCard = existingCard
        self.onFinish = onFinish

        _viewModel = StateObject(
            wrappedValue: PledgeViewModel(
                networkService: container.networkService
            )
        )
    }

    var body: some View {
        VStack {
            navigationBar
            ScrollView {
                Group {
                    description
                    writingPledge
                    emoji
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 100)
                
            }
            .safeAreaInset(edge: .bottom) {
                nextButton // 버튼 뒤로도 내용이 보이게 설정해놓음
            }
        }
        .onAppear {
            if mode == .edit,
               let card = existingCard {
                viewModel.setExistingCard(card)
            }
        }
        .navigationDestination(isPresented: $goNext) {
            CreatePledgeCardView(
                galaxy: galaxy,
                viewModel: viewModel,
                onFinish: {
                    goNext = false      // 먼저 CreatePledgeCardView 닫고
                    dismiss()           // WritePledgeView도 닫고
                    onFinish()          // Home으로 알림
                }
            )
        }

        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
        
    }
    
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "다짐 작성",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
    // MARK: - description
    private var description: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text("다짐 카드 작성하기")
                    .font(.pt18)
                    .foregroundStyle(.grayScale9)
                Text("기대되는 일, 이루고 싶은 마음을 자유롭게 적어주세요.\n세 가지가 아니어도 괜찮아요. 단 하나의 마음만으로도 충분하니까요.")
                    .font(.pt12)
                    .foregroundStyle(.grayScale5)
            }
            .padding(.top, 48)
            Spacer()
        }
        
    }
    
    // MARK: - writingPledge
    private var writingPledge: some View {
        VStack (alignment: .leading) {
            
            // 다짐 작성칸
            ForEach($viewModel.pledges) { $pledge in
                PledgeInputView(
                    text: $pledge.content,
                    example: pledge.example
                )
            }
            .padding(.top, 32)
            
            
            
            // 다짐 삭제/추가 버튼
            if mode == .create {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.removeLastPledge()
                    } label: {
                        Image("minus_icon")
                    }
                    .disabled(!viewModel.canRemove)
                    
                    Button(action: viewModel.addPledge) {
                        Image("plus_icon")
                    }
                    .disabled(!viewModel.canAdd)

                    
                }
            }

        }
    }
    
    // MARK: - emoji
    private var emoji: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text("이모지")
                    .font(.pt12)
                    .foregroundStyle(.grayScale9)
                
                
                Button {
                    viewModel.isEmojiSheetPresented = true
                } label: {
                    if let emoji = viewModel.selectedEmoji {
                                        Image(emoji.id)
                                    } else {
                                        Image("plus_emoji_icon")
                                    }
                }
                .sheet(isPresented: $viewModel.isEmojiSheetPresented) {
                    EmojiPickerSheet(
                        emojis: viewModel.emojis,
                        selectedEmojis: $viewModel.tempSelectedEmojis,
                        maxSelection: 1,
                        onConfirm: viewModel.confirmEmojiSelection,
                        onClose: {
                            viewModel.isEmojiSheetPresented = false
                        }
                    )
                }

            }
            Spacer()
        }
        .padding(.top, 50) // TODO: 패딩 값 수정 필요
    }
    
    // MARK: - nextBottom
    private var nextButton: some View {
        VStack {
            Spacer()
            // 다짐 1개 이상 작성 시 클릭 가능
            PrimaryButton(
                title: mode == .create ? "다음" : "수정하기",
                backgroundColor: viewModel.isNextEnabled ? .purpleC495E0 : .purpleC495E0.opacity(0.4)
            ) {
                if mode == .create {
                    goNext = true
                } else {
                    viewModel.patchPledge(galaxy: galaxy) { result in
                        switch result {
                        case .success:
                            LastGalaxyStore.save(galaxy.serverId) 
                            dismiss()
                            onFinish()
                        case .failure(let error):
                            print("❌ 수정 실패:", error)
                        }
                    }
                }
            }

            .disabled(!viewModel.isNextEnabled)
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    let container = DIContainer.preview
    
    let mockGalaxy = Galaxy(
        serverId: 1,
        title: "경주 여행",
        destination: "경주",
        startDate: Date(),
        endDate: Date().addingTimeInterval(60*60*24*3),
        totalDay: 4,
        galaxyIcon: "galaxy_1",
        dDay: 1,
        stars: []
    )

    NavigationStack {
        WritePledgeView(
            galaxy: mockGalaxy,
            container: container,
            onFinish: {
                print("다짐 작성 완료")
            }
        )
        .environmentObject(container)
    }
}


