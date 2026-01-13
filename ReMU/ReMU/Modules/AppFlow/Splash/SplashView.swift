//
//  SplashView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        Image("logo_primary")
            .resizable()
            .frame(width: 190, height: 190)
    }
}

#Preview {
    SplashView()
}
