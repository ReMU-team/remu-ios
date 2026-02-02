//
//  ProfileIntroView.swift
//  ReMU
//
//  Created by 김진서 on 2/3/26.
//

import SwiftUI

struct ProfileIntroView: View {
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
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
                Text("반가워요,  여행자님!")
                    .font(.pt24)
                    .foregroundStyle(.grayScale9)
                  .frame(maxWidth: .infinity, alignment: .leading)
                Text("프로필을 설정해주세요.")
                    .font(.pt24)
                    .foregroundStyle(.grayScale9)
                  .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 113)
        }
    }
}

#Preview {
    ProfileIntroView()
}
