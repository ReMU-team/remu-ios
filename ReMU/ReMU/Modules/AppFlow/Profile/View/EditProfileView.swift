//
//  EditProfileView.swift
//  ReMU
//
//  Created by 김진서 on 2/6/26.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {

    @StateObject private var viewModel =
        ProfileViewModel(
            networkService: NetworkServiceImpl(
                userSessionKeychain: UserSessionKeychainServiceImpl.shared
            )
        )

    @State private var imageLoader = ImageLoaderServiceImpl()
    @State private var selectedItem: PhotosPickerItem? = nil


    let initialName: String
    let initialIntroduction: String
    let imageUrl: String?

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
                    .padding(.horizontal, -40)
                Spacer()
                profileImageCircle
                nameAndIntroduction
                Spacer()
                finishButton
                
            }
            .padding(.horizontal, 40)
        }
        .onAppear {
            // 기존 값 세팅
            viewModel.username = initialName
            viewModel.description = initialIntroduction
        }
    }
    // MARK: - Navigation
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
    
    // MARK: - ProfileImage
    private var profileImageCircle: some View {
        VStack {
            // 프로필 이미지 영역
            ZStack {
                
                // 새 이미지 선택했으면 그걸 최우선 표시
                if let data = viewModel.selectedImageData,
                   let uiImage = UIImage(data: data) {
                    
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                    
                } else {
                    
                    // 서버 이미지 표시
                    switch imageLoader.state {
                        
                    case .idle, .loading:
                        Image("StandardProfile")
                            .resizable()
                            .scaledToFill()
                        
                    case .success(let image):
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        Image("StandardProfile")
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .frame(width: 132, height: 132)
            .clipShape(Circle())
            .task {
                await imageLoader.loadImage(from: imageUrl)
            }
            // 사진 선택
            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
                Text("사진 편집")
                    .font(.pt12)
                    .foregroundStyle(.purpleC495E0)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                            .stroke(.purpleC495E0)
                    )
            }
            .task(id: selectedItem) {
                guard let item = selectedItem else { return }
                
                if let data = try? await item.loadTransferable(type: Data.self),
                   let image = UIImage(data: data),
                   let compressedData = image.jpegData(compressionQuality: 0.3) {

                    viewModel.selectedImageData = compressedData
                }

            }
            .padding(.top, 12)
            .padding(.bottom, 48)
        }
    }
    
    // MARK: - 이름 & 소개
    private var nameAndIntroduction: some View {
        VStack(spacing: 40) {
            
            ReMUTextField(text: $viewModel.username, placeholder: "이름을 적어주세요", height: 40)
                .disabled(true) // 이름 수정 불가
            
            ReMUTextField(text: $viewModel.description, placeholder: "나에 대한 이야기 소개를 적어주세요", height: 80)
            
            
            
        }
    }
     // MARK: - Button
    private var finishButton: some View {
        VStack {
            // 수정 버튼 (PATCH 연결)
            PrimaryButton(
                title: "수정하기",
                backgroundColor: .purpleC495E0
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
    }
}

#Preview {
    EditProfileView(
        initialName: "레무",
        initialIntroduction: "우주 여행을 좋아해요 ✨",
        imageUrl: "https://picsum.photos/300",
        onBack: {},
        onFinish: {}
    )
}

