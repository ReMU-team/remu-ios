//
//  RootView.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct RootView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            AppFlowView()
        } else {
            AuthFlowView()

        }
    }
}


#Preview {
    RootView()
}
