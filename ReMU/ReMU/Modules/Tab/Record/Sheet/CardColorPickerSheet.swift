//
//  CardColorPickerSheet.swift
//  ReMU
//
//  Created by 김진서 on 1/30/26.
//

import SwiftUI

struct CardColorPickerSheet: View {

    let colors: [CardColor]
    @Binding var selectedColor: CardColor?
    let onClose: () -> Void

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 5
    )

    var body: some View {
        VStack {
            Text("카드 색상")
                .font(.pt16)
                .padding(.top, 40)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(colors) { color in
                    Image(color.assetName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 56, height: 56)
                        .overlay {
                            if selectedColor == color {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.purpleC495E0, lineWidth: 3)
                            }
                        }
                        .onTapGesture {
                            selectedColor = color
                            onClose()
                        }
                }
            }
            .padding(.top, 24)
            .padding(.horizontal, 40)

            Spacer()
        }
        .presentationDetents([.fraction(0.35)])
        .presentationDragIndicator(.visible)
    }
}



enum CardColor: String, CaseIterable, Identifiable {
    case planet_1
    case planet_2
    case planet_3
    case planet_4
    case planet_5
    case planet_6
    case planet_7
    case planet_8
    case planet_9
    case planet_10

    var id: String { rawValue }

    /// 에셋 이름 = 서버로 보내는 값
    var assetName: String {
        rawValue
    }
}


