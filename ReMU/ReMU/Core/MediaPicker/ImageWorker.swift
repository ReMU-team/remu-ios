//
//  ImageWorker.swift
//  ReMU
//
//  Created by 김종수 on 2/6/26.
//

import UIKit

actor ImageWorker {
    /// 설정을 인자로 전달받아 메인 액터 의존성을 제거합니다.
    /// error 방지
    /// let normalizedImage = await imageWorker.normalizeForDisplay( originalImage, quality: MediaPickerConfig.jpegCompressionQuality, maxDimension: MediaPickerConfig.displayMaxDimensions)
    func normalizeForDisplay(
        _ image: UIImage,
        quality: CGFloat,           // MediaPickerConfig.jpegCompressionQuality 대신
        maxDimension: CGFloat       // MediaPickerConfig.displayMaxDimensions 대신
    ) async -> UIImage {            // 내부에서 ImageProcessor를 await 하기 위해 async 추가
        
        guard let data = image.jpegData(compressionQuality: quality) else {
            return image
        }
        
        // ImageProcessor.downsampledImage가 @MainActor라면 await가 필요합니다.
        if let downsized = await ImageProcessor.downsampledImage(
            from: data,
            maxDimension: maxDimension
        ) {
            return downsized
        }
        
        return image
    }
}
