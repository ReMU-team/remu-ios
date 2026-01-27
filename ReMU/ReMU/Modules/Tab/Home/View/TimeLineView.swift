//
//  TimeLineView.swift
//  ReMU
//
//  Created by 김종수 on 1/26/26.
//

import Foundation
import SwiftUI

struct TimeLineView: View {
    
    var body: some View {
        ZStack{
            Color.blue212148.ignoresSafeArea()
            Image("Homegradation")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            Image("starObjet")
                .resizable()
                .scaledToFit()
            VStack{
                HStack{
                    Button(action:{}){
                        Image("white_left_arrow")
                    }
                    Spacer()
                    Button(action: {}){
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 24,height: 24)
                    }
                    Button(action: {}){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24,height: 24)
                    }
                }.padding(22)
                    .padding(.bottom,134)
                    .foregroundColor(.white)
                VStack{
                    Image("home_star")
                        .padding(.bottom,20)
                    Text("서로의 여정을 하나로 엮어요.\n 곧, 친구와 함께 만든 기록들이\n  하나의 타임라인으로 펼쳐집니다")
                        .font(.pt16)
                        .foregroundColor(.white)
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

