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
        
    }
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "6인팟 스위스", // TODO: 뷰모델에서 받아오기
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
        }
    }
    
    // MARK: - buttonGroup
    private var buttonGroup: some View {
        HStack (spacing: 8) {
            RecordSelectionButton(title: "카드색상")
            RecordSelectionButton(title: "이모지")
            RecordSelectionButton(title: "사진")
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
            // 다짐 1개 이상 작성 시 클릭 가능
            PrimaryButton(title: "분석하기", backgroundColor: .purpleC495E0) {
                goNext = true
            }
            .padding(.bottom, 54)
            
        }
        .padding(.horizontal, 40)
        
    }
}

#Preview {
//    WriteRecordView()
}
