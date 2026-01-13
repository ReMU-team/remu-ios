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
                    Image(systemName: "camera.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 132, height: 132)
                        .clipShape(Circle())
                        .foregroundColor(.purpleD9BCEA)
                }
            }
        }
        .padding()
        .onChange(of: selectedItem) { oldValue, newItem in
            Task {
                // 1. newItem(옵셔널)을 안전하게 꺼냅니다 (Unwrapping)
                if let newItem = newItem {
                    // 2. 이제 newItem은 옵셔널이 아니므로 바로 메서드 호출이 가능합니다.
                    if let data = try? await newItem.loadTransferable(type: Data.self) {
                        await MainActor.run {
                            self.selectedImageData = data
                            self.selectedImage = UIImage(data: data) // 변수명 일치시킴
                        }
                    }
                }
            }
        }
    }
}
