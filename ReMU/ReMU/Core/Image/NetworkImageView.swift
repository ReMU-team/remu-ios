//
//  NetworkImageView.swift
//  ReMU
//
//  Created by 김종수 on 2/5/26.
//

import Foundation
import SwiftUI

struct NetworkImageView: View {
    @State private var loader: any ImageLoaderService
    private let url: String?
    
    init(
        url: String?,
        loader: @autoclosure @escaping () -> any ImageLoaderService = ImageLoaderServiceImpl()
    ) {
        _loader = .init(initialValue: loader())
        self.url = url
    }
    var body: some View {
        Group {
            switch loader.state {
            case .idle, .loading:
                ProgressView("로딩 중")
            case .success(let image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure:
                Text("이미지 로드 실패")
            }
        }
        .task {
            await loader.loadImage(from: url)
        }
        .onDisappear {
            loader.cancel()
        }
    }
}
#Preview{
    NetworkImageView(url: "https://ssumer.com/wp-content/uploads/2010/11/Google-Chromessumercap010.jpg")
}
