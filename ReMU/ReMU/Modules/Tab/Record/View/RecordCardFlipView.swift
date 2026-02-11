//
//  RecordCardFlipView.swift
//  ReMU
//
//  Created by 원서우 on 1/23/26.
//

import Foundation
import SwiftUI
import Kingfisher


struct RecordCardFlip: View {
    
    @State var flip = false
    let model: RecordCardModel
    
    // MARK: - body
    var body: some View {
        ZStack {
            // 뒷면
            RecordCardOneView(
                flip: $flip,
                content: model.content,
                emojis: model.emojis
            )
                .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear.delay(0.35) : .linear, value: flip)
            // 앞면
            RecordCardTwoView(
                flip: $flip,
                galaxyName: model.galaxyName,
                travelPeriodText: model.travelPeriodText,
                title: model.title,
                image: model.image,
                imageUrl: model.imageUrl,
                dday: model.dday,
                dateText: model.dateText
            )                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear : .linear.delay(0.35), value: flip)
        }
        .onTapGesture {
            flip.toggle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color(red: 40/255, green: 40/255, blue: 40/255))
        .background(.clear) // 배경색 수정
    }
}



// MARK: - 뒷장
struct RecordCardOneView: View {
    
    @Binding var flip: Bool
    
    let content: String
    let emojis: [String]
    
    // MARK: - 뒷장 body
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
    
    // MARK: - 뒷장 top
    var top: some View {
        HStack {
            // 이모지
            HStack(spacing: 8) {
                ForEach(emojis, id: \.self) { emoji in
                    Image(emoji)
                        .resizable()
                        .frame(width: 28, height: 28)
                }
            }
            
            Spacer()
            
            // 생성 뷰에서는 안보일 예정
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image("pencil.line")
                    }
                }
            }
            
        }
        .padding(.top, 20)
        .padding(.bottom, 22)
    }
    
    // MARK: - 뒷장 middle
    var middle: some View {
        VStack {
            TextBox(text: content, isExpanded: true)
        }
        .padding(.bottom, 32)
    }
}

// MARK: - 앞장
struct RecordCardTwoView: View {
    
    @Binding var flip: Bool
    
    let galaxyName: String
    let travelPeriodText: String
    let title: String
    let image: UIImage?
    let imageUrl: String?
    let dday: Int
    let dateText: String
    
    // MARK: - 앞장 body
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(12)
                .shadow(radius: 8)
            VStack {
                top
                middle
                bottom
            }
            .padding(.horizontal, 24)
        }
        .frame(width: 297, height: 419)
    }
    
    // MARK: - 앞장 top
    var top: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(galaxyName)
                        .foregroundStyle(.grayScale9)
                        .font(.pt13)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("pencil.line")
                    }
                }
                Text(travelPeriodText)
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
            }
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom, 10)
    }
    
    // MARK: - 앞장 middle
    var middle: some View {
        VStack {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            } else if let imageUrl,
                      let url = URL(string: imageUrl) {

                KFImage(url)
                    .placeholder {
                        ProgressView()
                    }
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 8))

            } else {
                EmptyView()
            }
        }
    }

    
    // MARK: - 앞장 bottom
    var bottom: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Text("Day \(dday)")
                        .foregroundStyle(.grayScale9)
                        .font(.pt13)
                    Text("/ \(dateText)")
                        .foregroundStyle(.grayScale5)
                        .font(.pt12)
                }
                .padding(.bottom, 1)
                Text("\"\(title)\"")
                    .foregroundStyle(.grayScale9)
                    .font(.pt16)
            }
        }
        .padding(.bottom, 25)
    }
}

#Preview {
    RecordCardFlip(
        model: RecordCardModel(
            galaxyName: "6인팟 스위스",
            travelPeriodText: "25/10/29-25/11/10",
            title: "첫 기록",
            image: nil,
            imageUrl: nil,
            dday: 3,
            dateText: "10.31",
            content: "오늘은 정말 좋은 하루였다.\n날씨도 좋고 음식도 맛있었다.",
            emojis: ["smile", "heart"]
        )
    )
    .padding()
}

