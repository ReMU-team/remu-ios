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
    let card: PledgeCardModel
    @State var flip = false
    
    // MARK: - body
    var body: some View {
        ZStack {
            CardFrontView(card: card, flip: $flip)
                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear : .linear.delay(0.35), value: flip)
            
            CardBackView(card: card, flip: $flip)
                .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear.delay(0.35) : .linear, value: flip)
            
        }
        .frame(width: CardSize.width, height: CardSize.height)
        .onTapGesture {
            flip.toggle()
        }
        .background(Color.clear)// 배경색 수정
    }
}

// MARK: - 앞장
struct CardFrontView: View {
    let card: PledgeCardModel
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
            Image(card.emojiImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45, height: 45)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(card.galaxy.title)
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
                Text(card.galaxy.travelPeriodText)
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
            ForEach(card.pledges) { pledge in
                TextBox(text: pledge.content)
            }
            
        }
    }
}

// MARK: - 뒷장
struct CardBackView: View {
    let card: PledgeCardModel
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
            Image(card.emojiImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 45, height: 45)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(card.galaxy.title)
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
                Text(card.galaxy.travelPeriodText)
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



