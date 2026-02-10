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
    
    var body: some View {
        VStack(spacing: 8) {
            // 은하 아이콘
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 60,height: 60)
            
            // 은하 이름표 (캡슐 디자인 적용)
            Text(title)
                .font(.pt12)
                .foregroundColor(.white)
                .lineLimit(1) // 한 줄 유지
        }
    }
}
