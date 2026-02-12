//
//  GalaxyCell.swift
//  ReMU
//
//  Created by 김종수 on 1/23/26.
//

import Foundation
import SwiftUI

//개별 은하 아이템 셀 (재사용성 및 협업 효율을 위해 분리)
struct GalaxyCell: View {
    let galaxyId: Int
    let title: String
    let iconName: String
    var isEditing: Bool = false
    var onEditTap: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 8) {

            ZStack {
                Image(iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)

                if isEditing {
                    Button {
                        onEditTap?()
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 42, height: 42)

                            Image(systemName: "pencil")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.purpleC495E0)

                        }
                    }
                }
            }

            Text(title)
                .font(.pt12)
                .foregroundColor(.white)
                .lineLimit(1)

        }
    }
}

