//
//  TimeLineView.swift
//  ReMU
//
//  Created by 김종수 on 1/26/26.
//

import SwiftUI

struct TimeLineView: View {
    
    //뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack{
            // 배경 색
            Color.blue212148.ignoresSafeArea()
            
            // 배경 그라데이션
            GeometryReader { geometry in
                    Image("gradation")
                        .resizable()
                        .scaledToFill()
                        .scaleEffect(1.4)
                        .offset(x: -100, y: -100)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }
                .ignoresSafeArea() // 배경은 전체에 깔리게
                .allowsHitTesting(false) // 터치 방해 금지
            
            // 배경 별
            Image("starObjet")
                .resizable()
                .scaledToFit()
                .allowsHitTesting(false)
            VStack{
                HStack{
                    Button {
                        dismiss()
                    } label: {
                        Image("white_left_arrow")
                    }
                    Spacer()
                }
                .padding(22)
                .padding(.bottom,134)
                .foregroundColor(.white)
                VStack{
                    Image("home_star")
                        .padding(.bottom,20)
                    Text("서로의 여정을 하나로 엮어요.\n 곧, 친구와 함께 만든 기록들이\n  하나의 타임라인으로 펼쳐집니다")
                        .font(.pt16)
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom,31)
                    

                    Text("‘공동 타임라인’. 함께한 여행을 더욱 특별하게.")
                        .font(.pt16)
                        .foregroundColor(.white)
                        .padding(.bottom,56)
                    Button(action: {}){
                        Text("출시 시 알림받기")
                            .frame(height: 40)
                            .frame(width: .infinity)
                            .padding(.horizontal,66)
                            .foregroundStyle(.white)
                            .glassEffect(.clear.interactive(), in: .capsule)
                    }
                }
                Spacer()
            }
        }
    }
}



#Preview {
    TimeLineView()
}

