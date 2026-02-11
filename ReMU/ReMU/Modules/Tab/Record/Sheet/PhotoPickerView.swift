//
//  PhotoPickerView.swift
//  ReMU
//
//  Created by 김진서 on 1/30/26.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {

    @ObservedObject var viewModel: WriteRecordViewModel
    @State private var pickerItem: PhotosPickerItem?

    var body: some View {
        PhotosPicker(
            selection: $pickerItem,
            matching: .images
        ) {
            EmptyView()
        }
        .task(id: pickerItem) {
            guard let item = pickerItem else { return }
            await viewModel.setPhoto(from: item)
        }
        .presentationDetents([.fraction(0.5)])
        .presentationDragIndicator(.visible)
    }
}



#Preview {
    PhotoPickerView(viewModel: WriteRecordViewModel())
}
