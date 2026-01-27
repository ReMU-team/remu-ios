//
//  HomeView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import SwiftUI

struct HomeView: View {
    
    // 네비게이션
    @State private var showCreateGalaxy = false
    @State private var showWritePledge = false
    @State private var showWriteRecord = false
    @State private var showMenu = false
    
    
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
                    Button(action: {showMenu = true}){
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 24,height: 24)
                    }
                }.padding(22)
                    .foregroundColor(.white)
                Spacer()
                Button(action: {showCreateGalaxy = true}) {
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
                
                // TODO: UI 수정, 네비게이션 완료
                Button("📝 기록 생성") {
                    showWriteRecord = true
                }
                Button("✍️ 다짐 생성") { // TODO: 다짐카드 이미지 변경
                    showWritePledge = true
                }
            }
        }
        .fullScreenCover(isPresented: $showCreateGalaxy) {
            CreateGalaxyView()
        }
        .fullScreenCover(isPresented: $showMenu) {
            MenuView()
        }
        .fullScreenCover(isPresented: $showWritePledge) {
            NavigationStack {
                WritePledgeView(
                    onFinish: {
                        showWritePledge = false
                    }
                )
            }
        }
        .fullScreenCover(isPresented: $showWriteRecord) {
            NavigationStack {
                WriteRecordView(
                    onFinish: {
                        showWriteRecord = false
                    }
                )
            }
        }
    }
}

#Preview {
    HomeView()
}

//struct TempHomeView: View {
//
//    @State private var showCreateGalaxy = false
//    @State private var showWritePledge = false
//    @State private var showWriteRecord = false
//
//    var body: some View {
//        VStack(spacing: 20) {
//
//            Button("🌌 은하 생성") {
//                showCreateGalaxy = true
//            }
//
//            Button("✍️ 다짐 생성") {
//                showWritePledge = true
//            }
//
//            Button("📝 기록 생성") {
//                showWriteRecord = true
//            }
//        }
//        .fullScreenCover(isPresented: $showCreateGalaxy) {
//            CreateGalaxyView()
//        }
//        .fullScreenCover(isPresented: $showWritePledge) {
//            NavigationStack {
//                WritePledgeView(
//                    onFinish: {
//                        showWritePledge = false
//                    }
//                )
//            }
//        }
//
//        .fullScreenCover(isPresented: $showWriteRecord) {
//            NavigationStack {
//                WriteRecordView(
//                    onFinish: {
//                        showWriteRecord = false
//                    }
//                )
//            }
//        }
//    }
//}
