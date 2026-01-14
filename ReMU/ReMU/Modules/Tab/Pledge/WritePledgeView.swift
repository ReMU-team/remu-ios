//
//  WritePledgeView.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import SwiftUI

struct WritePledgeView: View {
    // 네비게이션 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 뷰모델 연결
    @StateObject private var viewModel = PledgeViewModel()
    
    @State private var pledge: String = ""
    
    // 다음 버튼
    @State private var goNext = false
    
    
    
    var body: some View {
        NavigationStack {
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
        }
        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
        
    }
    
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "6인팟 스위스",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
    // MARK: - description
    private var description: some View {
        HStack {
            VStack (alignment: .leading, spacing: 8) {
                Text("이번 여행,\n어떤 기분으로 떠나볼까요?")
                    .font(.pt20)
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
            ReMUTextField(placeholder: "떠나기 전의 마음을 남겨주세요", text: $pledge) // TODO: text 수정 필요 (viewmodel 관련)
                .padding(.top, 32)
                .padding(.bottom, 8)
            
            Text("예시: 외국인이랑 스몰토킹하기")
                .font(.pt12)
                .foregroundStyle(.grayScale5)
                .padding(.bottom, 2)
            
            
            // TODO: 다짐 삭제, 추가 버튼 만들기
            HStack {
                Spacer()
                
                Image("minus_icon")

                Image("plus_icon")
                
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
                Image("plus_emoji_icon") // TODO: 버튼으로 교체 후 시트 보이게
                    .padding(.horizontal, 14)
            }
            Spacer()
        }
        .padding(.top, 50) // TODO: 패딩 값 수정 필요
    }
    
    // MARK: - nextBottom
    private var nextButton: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "다음", backgroundColor: .purpleC495E0) {
                goNext = true
            }
            .navigationDestination(isPresented: $goNext) {
                CreatePledgeCardView()
            }
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    WritePledgeView()
}
