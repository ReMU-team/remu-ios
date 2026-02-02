//
//  RecordCardFlipView.swift
//  ReMU
//
//  Created by 원서우 on 1/23/26.
//

import Foundation
import SwiftUI

struct RecordCardFlip: View {
    
    @State var flip = false
    
    var body: some View {
        ZStack {
            RecordCardOneView(flip: $flip)
                .rotation3DEffect(.degrees(flip ? 0 : -90), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear.delay(0.35) : .linear, value: flip)
            RecordCardTwoView(flip: $flip)
                .rotation3DEffect(.degrees(flip ? 90 : 0), axis: (x: 0, y: 1, z: 0))
                .animation(flip ? .linear : .linear.delay(0.35), value: flip)
        }
        .onTapGesture {
            flip.toggle()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color(red: 40/255, green: 40/255, blue: 40/255))
        .background(.white) // 배경색 수정
    }
}

#Preview {
    RecordCardFlip()
}

// MARK: - 뒷장
struct RecordCardOneView: View {
    
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
        HStack (spacing: 16) {
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            Circle()
                .fill(.blue5050AE)
                .frame(width: 45, height: 45)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image("pencil.line")
                    }
                    
                    Button(action: {}) {
                        Image("close_icon")
                            
                    }
                }
            }
            
        }
        .padding(.top, 20)
        .padding(.bottom, 22)
    }
    
    var middle: some View {
        VStack {
            TextBox(text: "작성내용", isExpanded: true)
        }
        .padding(.bottom, 32)
    }
}

// 앞장
struct RecordCardTwoView: View {
    
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
                bottom
            }
            .padding(.horizontal, 24)
        }
        .frame(width: 297, height: 419)
    }
    
    var top: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("6인팟 스위스")
                        .foregroundStyle(.grayScale9)
                        .font(.pt13)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image("pencil.line")
                    }
                    
                    Button(action: {}) {
                        Image("close_icon")
                            
                    }
                }
                Text("25/10/29-25/11/10")
                    .foregroundStyle(.grayScale5)
                    .font(.pt12)
            }
            Spacer()
        }
        .padding(.top, 32)
        .padding(.bottom, 10)
    }
    
    var middle: some View {
        VStack {
            TextBox(text: "사진", isExpanded: true)
        }
        .padding(.bottom, 1)
    }
    
    var bottom: some View {
        HStack {
            Spacer()
            VStack(alignment: .trailing) {
                HStack {
                    Text("Day 3")
                        .foregroundStyle(.grayScale9)
                        .font(.pt13)
                    Text("/ 10.31.")
                        .foregroundStyle(.grayScale5)
                        .font(.pt12)
                }
                .padding(.bottom, 1)
                Text("\"작성한 제목\"")
                    .foregroundStyle(.grayScale9)
                    .font(.pt16)
            }
        }
        .padding(.bottom, 25)
    }
}

