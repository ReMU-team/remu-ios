//
//  ContentView.swift
//  ReMU
//
//  Created by 김진서 on 1/9/26.
//

import SwiftUI

struct ContentView: View {
    
    
    
    @State private var goNext = false

    var body: some View {
        NavigationStack {
            VStack {
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.blue333368)
                Text("Hello, world!")
                    .font(.pt32)
                
                // PrimaryButton
                PrimaryButton(title: "다음") {
                    goNext = true
                    print("다음 버튼 클릭")
                }
                .navigationDestination(isPresented: $goNext) {
                    NextView()
                }
                
                // TextBox
                Text("기대1") //Text(text) 이런식으로 받아와야함! UI 테스트용으로 기대1 적어놓음
                    .font(.pt16)
                    .foregroundStyle(.grayScale8) // TODO: 색 변경 필요
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(15)
                    .background(.purpleD9BCEA50)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ContentView()
}
