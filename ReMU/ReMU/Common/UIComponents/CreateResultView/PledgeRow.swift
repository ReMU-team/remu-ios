//
//  PledgeRow.swift
//  ReMU
//
//  Created by 원서우 on 1/28/26.
//

import Foundation
import SwiftUI

struct PledgeRow: View {
    @Binding var item: PledgeItem // ViewModel의 데이터와 연동
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                // 타이틀 (TextBox 컴포넌트라 가정)
                TextBox(text: item.title)
                
                // O 버튼 (성공)
                Button(action: {
                    // 이미 성공이면 취소, 아니면 성공으로 설정
                    item.status = (item.status == .success) ? .none : .success
                }) {
                    Image(systemName: item.status == .success ? "checkmark.circle.fill" : "checkmark.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.purpleC495E0)
                }
                
                // X 버튼 (실패)
                Button(action: {
                    // 이미 실패면 취소, 아니면 실패로 설정
                    item.status = (item.status == .fail) ? .none : .fail
                }) {
                    Image(systemName: item.status == .fail ? "xmark.circle.fill" :"xmark.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color.purpleC495E0)
                }
            }
            
            // 텍스트 필드
            ReMUTextField(text: $item.content, placeholder: "회고 내용을 입력해주세요.", height: 50)
        }
    }
}
