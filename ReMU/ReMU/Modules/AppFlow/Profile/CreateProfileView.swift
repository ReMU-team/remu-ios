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
        ZStack {
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
                .ignoresSafeArea()
                .allowsHitTesting(false)
            
            VStack {
                navigationBar
                    .padding(.horizontal, -40)
                    .padding(.bottom, 55)
                
                // 포토피커
                ProfileImage(selectedImageData: $viewModel.selectedImageData)
                    .padding(.bottom, 60)
                
                
                // MARK: - 이름 적기
                VStack (alignment: .leading, spacing: 5) {
                    
                    Text("이름*")
                        .font(.pt15)
                    
                    ReMUTextFieldOneLine(text: $viewModel.username, placeholder: "15자 이내로 입력해주세요", height: 32)
                }
                
                // TODO: 2자 이상 / 사용 가능한 닉네임입니다. 추가 필요!!
                Text("")
                    .padding(.top, 8)
                    .padding(.bottom, 34)
            
                    // MARK: - 한 줄 소개
                VStack (alignment: .leading, spacing: 5) {
                    
                    Text("한 줄 소개")
                        .font(.pt15)
                    
                    ReMUTextField(text: $viewModel.description, placeholder: "나에 대한 이야기 소개를 적어주세요", height: 80)
                    
                }
                
                Spacer()
                
                // MARK: - 시작 버튼
                PrimaryButton(
                    title: "시작하기", backgroundColor: .purpleC495E0
                ) {
                    viewModel.updateProfile()
                    onFinish()
                    print("시작 버튼 클릭")
                }
                //.padding(.top, 123)
                .padding(.bottom, 54)
            }
            .padding(.horizontal,40)
        }
        
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        HStack {
            Button {
                onBack()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
}

#Preview {
    CreateProfileView(
        onBack: {
            print("Back tapped")
        },
        onFinish: {
            print("Finish tapped")
        }
    )
}

