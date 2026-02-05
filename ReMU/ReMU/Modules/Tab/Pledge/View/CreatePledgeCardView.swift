//
//  CreatePledgeCardView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct CreatePledgeCardView: View {
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    let onFinish: () -> Void
    
    
    // 완료 버튼
    //@State private var goNext = false
    //@Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack{
            navigationBar
            Spacer()
            pledgeCardView
            Spacer()
            finishButton
        }
        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "다짐 생성",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
    // MARK: - pledgeCardView
    private var pledgeCardView: some View {
        VStack {
            Text("다짐 카드가 생성되었어요!")
                .font(.pt20)
                .foregroundStyle(.grayScale9)
            PledgeCardFlip()
                .padding(.top, 50)
                .padding(.bottom, 20)
            Text("카드를 클릭하면 뒷면이 보여요!")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
        }
    }
    
    // MARK: - finishButton
    private var finishButton: some View {
        VStack {
            PrimaryButton(title: "완료", backgroundColor: .purpleC495E0) {
                onFinish() // 홈으로 복귀
            }
            .padding(.horizontal, 40)
            .padding(.bottom, 54)
        }
        
        
    }
}

#Preview {
    NavigationStack {
        CreatePledgeCardView(
            onFinish: {
                print("Pledge card finished")
            }
        )
    }
}
