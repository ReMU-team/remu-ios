//
//  CreateRecordCardView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct CreateRecordCardView: View {
    @Environment(\.dismiss) private var dismiss
    
    // 완료 버튼
    @State private var goNext = false
    
    var body: some View {
        NavigationStack {
            navigationBar
            recordCardView
            finishButton
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
    
    // MARK: - recordCardView
    private var recordCardView: some View {
        VStack {
            Text("기록 카드가 생성되었어요!")
                .font(.pt18)
                .foregroundStyle(.grayScale9)
            CardFlip()
                .padding(.top, 50)
                .padding(.bottom, 20)
            Text("카드를 클릭하면 뒷면이 보여요!")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
        }
        .padding(.top, 64)
    }
    
    // MARK: - finishButton
    private var finishButton: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "완료", backgroundColor: .purpleC495E0) {
                goNext = true
            }
            .navigationDestination(isPresented: $goNext) {
                CreateGalaxyView() // TODO: 메인으로 변경 필요
            }
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    CreateRecordCardView()
}

