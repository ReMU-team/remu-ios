//
//  HomeView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import SwiftUI

struct HomeView: View {
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
                Spacer()
                Button(action: {}){
                    ZStack{
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                            .frame(width: 109,height: 109)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 35,height: 35)
                    }.foregroundColor(.white)
                }.padding(.bottom,16)
                Text("첫 은하 생성하기")
                    .font(.pt18)
                    .foregroundColor(.white)
                Spacer()
            }
        }
    }
}

#Preview {
    HomeView()
}
