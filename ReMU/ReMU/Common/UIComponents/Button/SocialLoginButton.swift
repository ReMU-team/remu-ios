//
//  SocialLoginButton.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import SwiftUI

struct SocialLoginButton: View {
    let type: SocialLoginType
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack (spacing: type.iconTextSpacing) {
                Spacer()
                
                Image(type.iconName)
                Text(type.title)
                    .font(.pt16)
                    .foregroundColor(type.textColor)

                Spacer()
            }
            .frame(height: 52)
            .background(type.backgroundColor)
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(type.borderColor ?? .clear, lineWidth: 1)
            )
        }
    }
}
