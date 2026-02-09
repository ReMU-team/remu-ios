//
//  EditProfileView.swift
//  ReMU
//
//  Created by 김진서 on 2/6/26.
//

import SwiftUI

struct EditProfileView: View {

    
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
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            
            VStack {
                navigationBar

                Spacer()
                
                // TODO: 포토피커 추가
                Image("StandardProfile")
                Text("사진 편집")
                    .font(.pt12)
                    .foregroundStyle(.purpleC495E0)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .frame(height: 24, alignment: .center)                    .overlay(
                        RoundedRectangle(cornerRadius: 26)
                    .inset(by: 0.5)
                    .stroke(.purpleC495E0)

                )
                
                
                
                // MARK: - 이름 적기
                VStack (alignment: .leading, spacing: 5) {
                    
                    Text("닉네임적는칸")
                    

                    
                    // MARK: - 한 줄 소개
                    VStack (alignment: .leading, spacing: 5) {
                        Text("한줄소개적는칸")
                        
                    }
                    Spacer()
                    
                    // MARK: - 시작 버튼
                    PrimaryButton(
                        title: "수정하기",
                        backgroundColor:
                            .purpleC495E0
                    ) {
                        onFinish()
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
    EditProfileView(
        onBack: {
            print("Back tapped")
        },
        onFinish: {
            print("Finish tapped")
        }
    )
}
