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
                    .foregroundStyle(.primaryPurple)
                Text("Hello, world!")
                    .font(.pt32)
                
                PrimaryButton(title: "다음") {
                    goNext = true
                    print("다음 버튼 클릭")
                }
                .navigationDestination(isPresented: $goNext) {
                    NextView()
                }
            }
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    ContentView()
}
