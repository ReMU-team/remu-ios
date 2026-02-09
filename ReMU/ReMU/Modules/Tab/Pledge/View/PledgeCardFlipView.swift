//
//  CardFlipView.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import SwiftUI
enum CardSize {
    static let width: CGFloat = 297
    static let height: CGFloat = 419
}

struct PledgeCardFlip: View {
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
        .frame(width: CardSize.width, height: CardSize.height)
        .onTapGesture {
            flip.toggle()
        }
        .background(Color.clear)// 배경색 수정
    }
}

#Preview {
    PledgeCardFlip()
}

// MARK: - 뒷장
struct CardOneView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(16)
                .shadow(radius: 8)
            VStack {
                top
                middle
            }
            .padding(.horizontal, 24)
        }
    }
    
    var top: some View {
        HStack {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    Button(action: {}) {
                        Image("pencil.line")
                            .foregroundStyle(Color.grayScale8)
                    }
                    Button(action: {}) {
                        Image("close_icon")
                            .foregroundStyle(Color.grayScale8)
                    }
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
                    .padding(.horizontal, 16)
            }
            
        }
        .padding(.top, 32)
        .padding(.bottom, 22)
    }
    
    var middle: some View {
        ZStack {
            Image("logo_illust_1")
    
        }
        .padding(.bottom, 24)
    }
}

// MARK: - CardTwoView
struct CardTwoView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(16)
                .shadow(radius: 8)
            VStack {
                top
                middle
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
    
    var top: some View {
        HStack {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                        .padding(.horizontal, 16)
                    
                    Spacer()
                    Button(action: {}) {
                        Image("pencil.line")
                            .foregroundStyle(Color.grayScale8)
                    }
                    Button(action: {}) {
                        Image("close_icon")
                            .foregroundStyle(Color.grayScale8)
                    }
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
                    .padding(.horizontal, 16)
            }
            
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

