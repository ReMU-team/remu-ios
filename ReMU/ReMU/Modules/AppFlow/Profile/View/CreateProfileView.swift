//
//  CreateProfileView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct CreateProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel

    let onBack: () -> Void
    let onFinish: () -> Void
    
    var body: some View {
        ZStack {
            // 배경 그라데이션
            GeometryReader { geometry in
                Image("gradation")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(1.5)
                    .offset(x: -100, y: -100)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            
            VStack {
                navigationBar
                
                Spacer()
                
                // 포토피커
                ProfileImage(selectedImageData: $viewModel.selectedImageData)
                    .padding(.top, 55)
                    .padding(.bottom, 46)
                
                
                
                // MARK: - 이름 적기
                VStack (alignment: .leading, spacing: 5) {
                    
                    Text("이름*")
                        .font(.pt15)
                    
                    ReMUTextField(
                        text: $viewModel.username,
                        placeholder: "15자 이내로 입력해주세요",
                        height: 32
                    )
                    .onSubmit {
                        Task {
                                await viewModel.validateNickname()
                            }                    }
                    
                    
                    // 가능 여부 메시지
                    Text(viewModel.nicknameMessage ?? "")
                        .font(.pt13)
                        .foregroundColor(
                            viewModel.isNicknameValid ? .true3 : .false3
                        )
                        .opacity(viewModel.nicknameMessage == nil ? 0 : 1)
                        .frame(height: 18, alignment: .leading)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    
                    
                    
                    
                    // MARK: - 한 줄 소개
                    VStack (alignment: .leading, spacing: 5) {
                        
                        Text("한 줄 소개")
                            .font(.pt15)
                        
                        ReMUTextField(text: $viewModel.description, placeholder: "나에 대한 이야기 소개를 적어주세요", height: 80)
                        
                    }
                    Spacer()
                    
                    // MARK: - 시작 버튼
                    PrimaryButton(
                        title: "시작하기",
                        backgroundColor: viewModel.isFinishEnabled
                        ? .purpleC495E0
                        : .purpleC495E0.opacity(0.4),
                        isDisabled: !viewModel.isFinishEnabled
                    ) {
                        Task {
                            let success = await viewModel.updateProfile()
                            if success {
                                onFinish()
                            }
                        }
                    }
                    .padding(.bottom, 54)
                    
                }
                .padding(.horizontal,40)
            }
        }
    }
    // MARK: - navigationBar
    private var navigationBar: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}

#Preview {
    CreateProfileView(
        viewModel: ProfileViewModel(
            networkService: NetworkServiceImpl(
                userSessionKeychain: UserSessionKeychainServiceImpl()
            ),
            appState: AppState()
        ),
        onBack: {},
        onFinish: {}
    )
}


