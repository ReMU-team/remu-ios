//
//  GalaxyCheckView.swift
//  ReMU
//
//  Created by 김종수 on 1/23/26.
//

import Foundation
import SwiftUI

struct GalaxyCheckView: View {
    
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 네비게이션
    @State private var showCreateGalaxy = false
    
    @State private var galaxies: [Galaxy] = []
    
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
                    // 뒤로가기
                    Button {
                        dismiss()
                    } label: {
                        Image("white_left_arrow")
                    }
                    
                    Spacer()
                    
                }
                .padding(22)
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
                    
                    // 은하 생성 버튼
                    PrimaryButton(title: "은하 생성하기",backgroundColor: .purpleC495E0 , action: {showCreateGalaxy = true})
                }
                .padding(.horizontal,40)
                
                // 은하 생성 뷰로 이동
                .fullScreenCover(isPresented: $showCreateGalaxy) {
                    CreateGalaxyView { galaxy in
                            galaxies.append(galaxy)
                        }
                }
            }
        }
    }
}



#Preview {
    GalaxyCheckView(galaxyList: [GalaxyData.mock])
}

