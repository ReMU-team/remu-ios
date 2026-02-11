//
//  WriteResultView.swift
//  ReMU
//
//  Created by 원서우 on 1/18/26.
//

import Foundation
import SwiftUI

struct WriteResultView: View {
    
    @StateObject var viewModel: ResultViewModel
    
    let onFinish: () -> Void
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            VStack {
                navigationBar
            }
            //        .navigationDestination(isPresented: $goNext) {
            //                    CreateResultCardView(onFinish: onFinish)
            //                }
            //        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
            ScrollView {
                VStack(spacing: 24) {
                    top
                    middle
                    nextButton
                }
            }
    //        bottom
        }
        
    }
    
    // MARK: - navigation
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "회고 작성",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
    // MARK: - top
    var top: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("은하의 여정을 회상해봐요")
                    .font(.pt20)
                    .foregroundStyle(.grayScale9)
                VStack(alignment: .leading, spacing: 4) {
                    Text("이번 여행을 회고해보아요!")
                        .font(.pt12)
                        .foregroundStyle(.grayScale5)
                    Text("출발 전에는 이렇게 작성하였어요.")
                        .font(.pt12)
                        .foregroundStyle(.grayScale5)
                }
                Text("지금의 나는 어떤가요?")
                    .font(.pt13)
                    .foregroundStyle(.grayScale7)
            }
            Spacer()
        }
        .padding()
    }
    
    // MARK: - middle
    var middle: some View {
        VStack(spacing: 35) {
            emoji
            
            ForEach($viewModel.pledges) { $item in
                PledgeRow(item: $item)
            }
            
            overall
        }
        .padding()
    }
    
    var emoji: some View {
        HStack {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            VStack(alignment: .leading) {
                HStack {
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
                    Button(action: {
                        viewModel.openEmojiSheet()
                    }) {
                        Text("회고 이모지 변경")
                            .foregroundStyle(.purpleC495E0)
                            .font(.pt12)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .frame(height: 24, alignment: .center)
                            .background(.white.opacity(0.32))
                            .cornerRadius(26)
                            .overlay(
                            RoundedRectangle(cornerRadius: 26)
                            .inset(by: 0.5)
                            .stroke(Color.purpleC495E0, lineWidth: 1)
                            )
                    }
                    .sheet(isPresented: $viewModel.isEmojiSheetPresented) {
                        EmojiPickerSheet(
                                emojis: viewModel.emojis,
                                selectedEmojis: $viewModel.tempSelectedEmojis,
                                maxSelection: 1,
                                onConfirm: {
                                    viewModel.confirmEmojiSelection()
                                },
                                onClose: {
                                    viewModel.isEmojiSheetPresented = false
                                }
                            )
                    }

                    
                    
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
            }
        } // TODO: emoji + 은하이름 + 여행날짜 컴포넌트화, MVVM 구조화, 회고이모지변경 버튼 액션
    }
    
    var overall: some View {
        VStack(alignment: .leading) {
            Text("여행 후기")
                .font(.pt15)
                .foregroundStyle(.grayScale9)
            ReMUTextField(text: $viewModel.review, placeholder: "여행 후기를 입력해주세요.", height: 195)
        }
    }

    
    // MARK: - bottom
    var bottom: some View {
        VStack {
            
        }
    }
    
    // MARK: - nextBottom
    private var nextButton: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "회고 분석하기", backgroundColor: .purpleC495E0) {
                viewModel.submitResult {
                    onFinish()
                }
            }
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    let container = DIContainer.preview
    
    WriteResultView(
        viewModel: container.makeResultViewModel(),
        onFinish: {}
    )
}


