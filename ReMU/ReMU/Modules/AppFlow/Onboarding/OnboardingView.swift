//
//  OnboardingView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0
    let onExit: () -> Void
    let onFinish: () -> Void
    
    var body: some View {
        VStack {
            navigationBar
            Spacer()
            contents
            buttons
            Spacer()
            
        }
        
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        HStack {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                } else {
                    onExit()   // 로그인 화면으로 복귀
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.grayScale9)
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    // MARK: - contents
    private var contents: some View {
        let page = onboardingPages[currentIndex]
        return VStack {
            Text(page.title)
                .font(.pt20)
                .foregroundStyle(.grayScale9)
                .padding(.bottom, 12)
            
            Text(page.description)
                .font(.pt15)
                .padding(.bottom, 48)
                .foregroundStyle(.grayScale5)
            
            Image(page.imageName)
                .resizable()
                .frame(width: 313, height: 304)
                .padding(.bottom, 64)
            
            // page indicator
            HStack(spacing: 12) {
                ForEach(0..<onboardingPages.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.purpleC495E0 : Color.grayScale3)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.bottom, 24)
        }
    }
    // MARK: - buttons
    private var buttons: some View {
        VStack {
            PrimaryButton(title: "다음 단계", backgroundColor: .purpleC495E0) {
                if currentIndex < onboardingPages.count - 1 {
                    currentIndex += 1
                } else {
                    onFinish()
                }
            }
            .padding(.horizontal,40)
            
            Text("건너뛰기")
                .font(.pt12)
                .foregroundStyle(.grayScale3)
                .underline()
                .padding(.top, 12)
                
            
        }
    }
    
}





