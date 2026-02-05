//
//  WriteRecordView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct WriteRecordView: View {
    
    let onFinish: () -> Void
    
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 뷰모델
    @StateObject private var viewModel = WriteRecordViewModel()

    
    // 제목 TODO: 뷰모델 제작 후 변경
    @State private var title: String = ""
    
    // 내용 TODO: 뷰모델 제작 후 변경
    @State private var content: String = ""

    
    // 다음 버튼
    @State private var goNext = false
    
    var body: some View {
        VStack {
            navigationBar
            Group {
                writeTitle
                buttonGroup
                    .padding(.horizontal, 41)
                writeContent
            }
            .padding(.horizontal, 32)
            nextButton
        }
        .navigationDestination(isPresented: $goNext) {
            CreateRecordCardView(onFinish: onFinish)
        }
        .sheet(isPresented: $viewModel.isEmojiSheetPresented) {
            EmojiPickerSheet(
                emojis: viewModel.emojis,
                selectedEmojis: $viewModel.tempSelectedEmojis,
                maxSelection: 3,
                onConfirm: viewModel.confirmEmojiSelection,
                onClose: {
                    viewModel.isEmojiSheetPresented = false
                }
            )
        }


        .sheet(isPresented: $viewModel.isColorSheetPresented) {
            CardColorPickerSheet(
                colors: viewModel.cardColors,
                selectedColor: $viewModel.selectedCardColor,
                onClose: { viewModel.isColorSheetPresented = false }
            )
        }

        .sheet(isPresented: $viewModel.isPhotoPickerPresented) {
            PhotoPickerView(viewModel: viewModel)
        }

        
    }
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "기록 작성",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
    // MARK: - writeTitle
    private var writeTitle: some View {
        VStack (alignment: .leading) {
            
            // 날짜 표시
            HStack (spacing: 4) {
                Text("Day 3")
                    .font(.pt18)
                    .foregroundStyle(.grayScale9)
                Text("/")
                    .font(.pt13)
                    .foregroundStyle(.grayScale7)
                Text("10.31")
                    .font(.pt15)
                    .foregroundStyle(.grayScale5)
                
                Spacer()
                
                if let color = viewModel.selectedCardColor {
                    Image(color.assetName)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .shadow(radius: 8)
                }

            }
            .padding(.top,37)
            .padding(.bottom, 24)
            
            // 제목 작성칸
            TextField("제목", text: $title) // TODO: 뷰모델로 변경 필요
                .font(.pt18)
                .foregroundStyle(.grayScale9)
                .textFieldStyle(.plain)
            
            // 밑줄
            Rectangle()
                .fill(.grayScale7)
                .frame(height: 1)
            
            HStack(spacing: 8) {
                ForEach(viewModel.selectedEmojis) { emoji in
                    Image(emoji.id)
                        .resizable()
                        .frame(width: 32, height: 32)
                }

                if viewModel.selectedPhoto != nil {
                    Text("사진")
                }
            }
            .padding(.top, 12)

        }
    }
    
    // MARK: - buttonGroup
    private var buttonGroup: some View {
        HStack (spacing: 8) {
            RecordSelectionButton(title: "카드색상")
                .onTapGesture {
                    viewModel.isColorSheetPresented = true
                }

            RecordSelectionButton(title: "이모지")
                .onTapGesture {
                    viewModel.openEmojiSheet()
                }


            RecordSelectionButton(title: "사진")
                .onTapGesture {
                    viewModel.isPhotoPickerPresented = true
                }

        }
        .padding(.top, 71)
        .padding(.bottom, 48)
    }
    
    
    
    // MARK: - writeContent
    private var writeContent: some View {
        
        ZStack(alignment: .topLeading) {
            if content.isEmpty {
                Text("내용을 입력하세요")
                    .font(.pt18)
                    .foregroundStyle(.grayScale4)
                    .padding(.top, 8)
                    .padding(.leading, 4)
            }
            
            TextEditor(text: $content)
                .font(.pt18)
                .foregroundStyle(.grayScale9)
                .background(Color.clear)
                .scrollContentBackground(.hidden)
                
        }
        .frame(minHeight: 200)
    }
    
    
    // MARK: - nextButton
    private var nextButton: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "분석하기", backgroundColor: .purpleC495E0) {
                goNext = true
            }
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    NavigationStack {
        WriteRecordView(
            onFinish: {
                print("finish")
            }
        )
    }
}

