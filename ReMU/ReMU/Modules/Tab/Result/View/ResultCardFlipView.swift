//
//  ResultCardFlipView.swift
//  ReMU
//
//  Created by 원서우 on 1/18/26.
//

import Foundation
import SwiftUI

struct ResultCardFlip: View {
    
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var appState: AppState

    @ObservedObject var resultVM: ResultViewModel

    @State private var flip = false

    
    var body: some View {
        ZStack {
            ResultCardOneView(
                flip: $flip,
                feedbackContent: resultVM.aiFeedback
            )
            .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))

            ResultCardTwoView(flip: $flip)
                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
        }
        .onTapGesture {
            flip.toggle()
            if flip {
                resultVM.fetchResult()
            }
        }
        .frame(width: 297, height: 419)
    }
}

#Preview {
    ResultCardOneView(
        flip: .constant(false),
        feedbackContent: "AI 피드백 예시입니다."
    )
}


struct ResultCardOneView: View {
    
    @Binding var flip: Bool
    let feedbackContent: String?
    
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
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
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
        VStack {
            Text(feedbackContent ?? "AI 피드백을 불러오는 중…")
                .foregroundStyle(.blue333368)
                .font(.pt12)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .cornerRadius(10)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color.purpleD9BCEA, lineWidth: 1)

                )
        }
        .padding(.bottom, 32)
    }
}

struct ResultCardTwoView: View {
    
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
            Text("나의 회고카드")
                .foregroundStyle(.grayScale5)
                .font(.pt12)
            TextBox(text: "여행 전 다짐 내용", isExpanded: true)
            Text("여행 후 회상 내용(+총평)")
                .foregroundStyle(.blue333368)
                .font(.pt12)
                .frame(maxWidth: .infinity, minHeight: 135, maxHeight: 135, alignment: .center)
                .cornerRadius(10)
                .overlay(
                RoundedRectangle(cornerRadius: 10)
                .inset(by: 0.5)
                .stroke(Color.purpleD9BCEA, lineWidth: 1)

                )
        }
        .padding(.bottom, 24)
    }
}

