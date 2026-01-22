//
//  WritePledgeView.swift
//  ReMU
//
//  Created by 김진서 on 1/14/26.
//

import SwiftUI

struct WritePledgeView: View {
    let onFinish: () -> Void
    // 네비게이션 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 뷰모델 연결
    @StateObject private var viewModel = PledgeViewModel()
    
    // 다음 버튼
    @State private var goNext = false
    
    
    
    var body: some View {
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
        .navigationDestination(isPresented: $goNext) {
                    CreatePledgeCardView(onFinish: onFinish)
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
            
            // 다짐 작성칸 // TODO: 텍스트필드 UI 수정 필요
            ForEach($viewModel.pledges) { $pledge in
                PledgeInputView(
                    text: $pledge.content,
                    example: pledge.example
                )
            }
            .padding(.top, 32)
            
            
            
            // 다짐 삭제/추가 버튼
            HStack {
                Spacer()
                
                // 다짐 삭제하기
                Button {
                    viewModel.removeLastPledge()
                } label: {
                    Image("minus_icon")
                }
                .disabled(!viewModel.canRemove)

                
                // 다짐 추가하기
                Button(action: viewModel.addPledge) {
                    Image("plus_icon")
                }
                .disabled(!viewModel.canAdd)

                
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
                
                
                Button {
                    viewModel.isEmojiSheetPresented = true
                } label: {
                    if let emoji = viewModel.selectedEmoji {
                                        Image(emoji.id)
                                    } else {
                                        Image("plus_emoji_icon")
                                    }
                }
                .sheet(isPresented: $viewModel.isEmojiSheetPresented) {
                    EmojiPickerSheet(
                        emojis: viewModel.emojis,
                        selectedEmoji: $viewModel.tempSelectedEmoji,
                        onConfirm: {
                            viewModel.confirmEmojiSelection()
                        },
                        onClose: {
                            viewModel.isEmojiSheetPresented = false
                        }
                    )
                }

            }
            Spacer()
        }
        .padding(.top, 50) // TODO: 패딩 값 수정 필요
    }
    
    // MARK: - nextBottom
    private var nextButton: some View {
        VStack {
            Spacer()
            // 다짐 1개 이상 작성 시 클릭 가능
            PrimaryButton(title: "다음",
                          backgroundColor: viewModel.isNextEnabled ? .purpleC495E0 : .grayScale3
            ) {
                goNext = true
            }
            .disabled(!viewModel.isNextEnabled)
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
//    WritePledgeView()
}
