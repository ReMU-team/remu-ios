import SwiftUI
import PhotosUI

struct ProfileImage: View {
    @Binding var selectedImageData: Data?
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil // UI 표시용
    
    var body: some View {
        VStack(spacing: 20) {
            PhotosPicker(selection: $selectedItem, matching: .images) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 132, height: 132)
                        .clipShape(Circle())
                } else {
                    Image("camera_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 132, height: 132)
                        .clipShape(Circle())
                        .foregroundStyle(Color.purpleD9BCEA)
                }
            }
        }
        .padding()
        .task(id: selectedItem) {
            guard let selectedItem else { return }
            
            if let data = try? await selectedItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                
                // 이미지 압축
                var quality: CGFloat = 0.7
                var compressedData = image.jpegData(compressionQuality: quality)
                
                while let d = compressedData,
                      d.count > 1_000_000,
                      quality > 0.1 {
                    
                    quality -= 0.1
                    compressedData = image.jpegData(compressionQuality: quality)
                }
                
                selectedImageData = compressedData
                selectedImage = UIImage(data: compressedData ?? data)
            }
        }
    }
}
