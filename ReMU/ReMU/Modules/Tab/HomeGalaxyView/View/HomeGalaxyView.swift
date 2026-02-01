//
//  testView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import Foundation
import SwiftUI

struct HomeGalaxyView: View {
    @StateObject private var viewModel = HomeGalaxyViewModel()

    var body: some View {
        ZStack {
            // 1. 배경 레이어
            Color.blue212148.ignoresSafeArea()
            Image("Homegradation")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .ignoresSafeArea()
            
            Image("starObjet")
                .resizable()
                .scaledToFit()
            
            // 2. 메인 은하 시스템 (중앙 배치)
            if let data = viewModel.galaxy {
                GalaxySystemView(
                    galaxy: data,
                    partitionedStars: viewModel.partitionedStars,
                    scale: viewModel.scale // 줌 배율 전달
                )
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            viewModel.updateScale(magnitude: value.magnitude)
                        }
                )
            } else {
                ProgressView().tint(.white)
            }
            VStack(alignment: .trailing){
                Spacer()
                HStack{
                    Spacer()
                    Button(action:{}){
                        Image("card")
                            .shadow(color: .white ,radius:5, x: 2, y: 4)
                    }.padding(.trailing, 22) // 화면 끝에서 살짝 띄우기
                        .padding(.bottom, 20)   // 하단에서 살짝 띄우기
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity) // 화면 전체를 차지하게 하여 Spacer가 작동하게 함
                .allowsHitTesting(true) // 하위 버튼 클릭 가능하도록 보장
            
            
            // 3. 상단 정보 UI (줌 영향 없이 고정)
            VStack {
                HStack{
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
                }.padding(.bottom,27)
                    .foregroundColor(.white)
                VStack(spacing: 8) {
                    HStack(spacing: 4) {
                        Text(viewModel.galaxy?.title ?? "Loading...")
                            .font(.pt24)
                        
                        Button(action: {}) {
                            Image(systemName: "greaterthan")
                                .padding(.leading,7)
                                
                        }
                        
                    }.foregroundColor(.white)
                    
                    if let data = viewModel.galaxy {
                        Text("Day \(data.totalDay) | \(data.month)월 \(data.day)일")
                            .font(.pt16)
                            .foregroundColor(.white)
                    }
                }
                
                Spacer() // 텍스트를 상단으로 밀어냄
                Button(action:{}){
                    ZStack{
                        Circle()
                            .foregroundColor(.white.opacity(0.3))
                            .frame(width: 54,height: 54)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18,height: 18)
                            .foregroundColor(.white)
                    }
                }
            }.padding(.horizontal,22)
        }
        .modifier(ActionAlertModifier())
    }
}
#Preview {
    HomeGalaxyView()
}
