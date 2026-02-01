//
//  CardFlipView.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import SwiftUI

struct PledgeCardFlip: View {
    
    // 뷰모델
    @StateObject private var pledgeViewModel = PledgeViewModel()
    @StateObject private var galaxyViewModel = CreateGalaxyViewModel()
    
    @State var flip = false
    
    var body: some View {
        ZStack {
            CardOneView(flip: $flip)
                .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear.delay(0.35) : .linear, value: flip)
            CardTwoView(flip: $flip)
                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear : .linear.delay(0.35), value: flip)
        }
        .onTapGesture {
            flip.toggle()
        }
        // 티모가 다른 뷰에서 패딩 문제로 지움
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        
        //.background(Color(red: 40/255, green: 40/255, blue: 40/255))
        .background(.white) // 배경색 수정
    }
}

#Preview {
    PledgeCardFlip()
}

struct CardOneView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(12)
                .shadow(radius: 8)
            VStack {
                top
                middle
            }
            .padding(.horizontal, 24)
        }
        .frame(width: 297, height: 419)
    }
    
    var top: some View {
        HStack {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            VStack(alignment: .leading) {
                HStack {
//                    Text("galaxyViewModel.galaxyName")
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
                    Image(systemName: "pencil.line")
                    Image(systemName: "xmark.app")
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
                
            }
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom, 22)
    }
    
    var middle: some View {
        ZStack {
            TextBox(isExpanded: true)
            Image("logo_illust_1")
        }
        .padding(.bottom, 32)
    }
}

struct CardTwoView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(12)
                .shadow(radius: 8)
            VStack {
                top
                middle
                Spacer()
            }
            .padding(.horizontal, 24)
        }
        .frame(width: 297, height: 419)
    }
    
    var top: some View {
        HStack {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            VStack(alignment: .leading) {
                HStack {
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "pencil.line")
                            .foregroundStyle(Color.grayScale8)
                    }
                    Button(action: {}) {
                        Image(systemName: "xmark.app")
                            .foregroundStyle(Color.grayScale8)
                    }
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
            }
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom, 22)
    }
    
    var middle: some View {
        VStack(alignment: .leading) {
            Text("나의 다짐카드")
                .foregroundStyle(.grayScale5)
                .font(.pt12)
            TextBox(text: "다짐 1")
            TextBox(text: "다짐 2")
            TextBox(text: "다짐 3")
        }
    }
}

