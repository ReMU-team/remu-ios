//
//  CreateProfileView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct CreateProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    let onBack: () -> Void // 뒤로가기 콜백 (온보딩 첫화면으로 이동)
    let onFinish: () -> Void // 완료 콜백 (메인 화면으로 이동)
    
    var body: some View {
        VStack {
            navigationBar
                .padding(.horizontal, -40)
            
            // 포토피커
            ProfileImage(selectedImageData: $viewModel.selectedImageData)
            
            // 이름 적기
            ReMUTextField(placeholder: "15자 이내로 입력해주세요", text: $viewModel.username)
            
            // 한 줄 소개
            ReMUTextField(placeholder: "나에 대한 이야기 소개를 적어주세요", text: $viewModel.description)
            
            // 시작 버튼
            PrimaryButton(
                title: "시작하기", backgroundColor: .purpleC495E0
            ) {
                viewModel.updateProfile()
                onFinish()
                print("시작 버튼 클릭")
            }
        }
        .padding(.horizontal,40)
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.grayScale9)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    
    
}
    
    
