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
                viewModel: resultVM,
                feedbackContent: resultVM.aiFeedback
            )
            .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))

            ResultCardTwoView(
                flip: $flip,
                viewModel: resultVM
            )
                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
        }
        .task {
            resultVM.fetchResult()
        }
        .frame(width: 297, height: 419)
    }
}



struct ResultCardOneView: View {
    
    @Binding var flip: Bool
    @ObservedObject var viewModel: ResultViewModel
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
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 45, height: 45)
                
                if let emoji = viewModel.selectedEmoji {
                    Image(emoji.id)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.galaxyTitle)
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "xmark.app")
                            .foregroundStyle(Color.grayScale8)
                    }
                }
                Text(viewModel.travelDate)
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
    @ObservedObject var viewModel: ResultViewModel
    
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
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 45, height: 45)
                
                if let emoji = viewModel.selectedEmoji {
                    Image(emoji.id)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                }
            }
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.galaxyTitle)
                        .foregroundStyle(.grayScale9)
                        .font(.pt20)
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "xmark.app")
                            .foregroundStyle(Color.grayScale8)
                    }
                }
                Text(viewModel.travelDate)
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
            
            ForEach(viewModel.pledges, id: \PledgeItem.id) { (pledge: PledgeItem) in
                VStack(alignment: .leading, spacing: 4) {
                    Text(pledge.title)
                        .font(.pt12)
                        .foregroundStyle(.grayScale8)

                    Text(pledge.content)
                        .font(.pt12)
                        .foregroundStyle(.grayScale5)
                }
            }

            Text(viewModel.review)
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

