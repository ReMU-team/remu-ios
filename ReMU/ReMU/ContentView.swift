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
                // PrimaryButton
                PrimaryButton(title: "다음") {
                    goNext = true
                    print("다음 버튼 클릭")
                }
                .navigationDestination(isPresented: $goNext) {
                    NextView()
                }
                
                TextBox(text: "텍스트")
                
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ContentView()
}
