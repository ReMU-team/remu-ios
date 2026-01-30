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
        .onChange(of: pickerItem) { newItem in
            viewModel.setPhoto(from: newItem)
        }
    }
}


#Preview {
    PhotoPickerView(viewModel: WriteRecordViewModel())
}
