//
//  GalaxyCheckView.swift
//  ReMU
//
//  Created by 김종수 on 1/23/26.
//

import Foundation
import SwiftUI

struct GalaxyCheckView: View {
    let galaxyList: [GalaxyData]
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
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
                    .foregroundColor(.white)
                Text("나의 우주")
                    .font(.pt24)
                    .foregroundColor(.white)
                    .padding(.bottom,31)
                HStack{
                    Spacer()
                    Button(action:{}){
                        Text("은하 편집")
                            .font(.pt12)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8) // 텍스트 좌우 여백 (글자가 길어져도 이 간격은 유지됨)
                            .padding(.vertical, 4)
                            .background(Capsule().fill(Color.white.opacity(0.3))
                            ) // 배경색 설정
                    }.padding(.horizontal,22)
                        .padding(.bottom,24)
                }
                ScrollView{
                    LazyVGrid(columns: columns,spacing: 20){
                        ForEach(galaxyList){galaxy in
                            GalaxyCell(galaxy: galaxy)}
                    }
                }.padding(.horizontal,22)
                Spacer()
                HStack(spacing: 9){
                PrimaryButton(title: "히스토리", action: {})
                PrimaryButton(title: "은하 생성하기",backgroundColor: .purpleC495E0 , action: {})
                }.padding(.horizontal,40)
            }
        }
    }
}



#Preview {
    GalaxyCheckView(galaxyList: [GalaxyData.mock])
}

