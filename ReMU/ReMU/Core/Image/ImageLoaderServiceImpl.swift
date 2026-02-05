//
//  ImageLoaderServiceImpl.swift
//  ReMU
//
//  Created by 김종수 on 2/5/26.
//

import UIKit
import Combine
import Kingfisher

@Observable
final class ImageLoaderServiceImpl: ImageLoaderService {
    private(set) var state: ImageLoadState = .idle
    private var currentTask: DownloadTask?
    
    func loadImage(from urlString: String?) async {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.state = .failure(URLError(.badURL))
            return
        }
        
        state = .loading
        
        // 1. [해결] UIScreen.main.scale 경고 해결용 로직
        let screenScale: CGFloat = await MainActor.run {
            let activeScene = UIApplication.shared.connectedScenes
                .first { $0.activationState == .foregroundActive } as? UIWindowScene
            return activeScene?.screen.scale ?? 3.0
            }
        
        let options: KingfisherOptionsInfo = [
            .cacheOriginalImage,
            .transition(.fade(0.2)),
            // 400으로 고정한 이유는, 피그마 디자인상 이보다 더 큰 이미지가 존재하지 않기 때문.
            .processor(DownsamplingImageProcessor(size: CGSize(width: 400, height: 400))),
            .scaleFactor(screenScale),
            .cacheSerializer(DefaultCacheSerializer.default)
        ]
        
        do {
            let image = try await retrieveImageAsync(with: url, options: options)
            self.state = .success(image)
        } catch {
            self.state = .failure(error)
        }
        
    }
    
    /// `KingfisherManager`의 클로저 기반 `retrieveImage`를 async/await 방식으로 래핑합니다.
    private func retrieveImageAsync(
        with url: URL,
        options: KingfisherOptionsInfo
    ) async throws -> UIImage {
        try await withCheckedThrowingContinuation { continuation in
            currentTask = KingfisherManager.shared.retrieveImage(
                with: url,
                options: options,
                completionHandler: { result in
                    switch result {
                    case .success(let value):
                        continuation.resume(returning: value.image)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
            )
        }
    }
    
    func cancel() {
        currentTask?.cancel()
        currentTask = nil
    }
}
