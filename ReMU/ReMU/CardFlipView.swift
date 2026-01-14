//
//  CardFlipView.swift
//  ReMU
//
//  Created by 김종수 on 1/13/26.
//

import SwiftUI

struct CardFlip: View {
    
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        //.background(Color(red: 40/255, green: 40/255, blue: 40/255))
        .background(.white) // 배경색 수정
    }
}

#Preview {
    CardFlip()
}

struct CardOneView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
                .cornerRadius(12)
                .shadow(radius: 8)
            Text("Back Side")
                .foregroundStyle(.black)
                .font(.largeTitle)
        }
        .frame(width: 270, height: 400)
    }
}

struct CardTwoView: View {
    
    @Binding var flip: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .cornerRadius(12)
                .shadow(radius: 8)
            Text("Front Side")
                .foregroundStyle(.white)
                .font(.largeTitle)
        }
        .frame(width: 270, height: 400)
    }
}

