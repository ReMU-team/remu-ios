import SwiftUI
/*
struct ContentView: View {
    // 본인이 작업한 ViewModel
    @StateObject private var viewModel = ProfileViewModel()
    
    // 팀원이 추가한 내비게이션 상태 (필요시 사용)
    @State private var goNext = false

    var body: some View {
        NavigationStack {

            ScrollView { // 내용이 많아질 수 있으므로 ScrollView 권장
                VStack(spacing: 30) {
                    
                    // --- 프로필 수정 섹션 ---
                    VStack(spacing: 20) {
                        ProfileImage(selectedImageData: $viewModel.selectedImageData)
                        
                        TextField("이름", text: $viewModel.username)
                            .textFieldStyle(.roundedBorder)
                            .padding(.horizontal)
                        
                        Button(action: {
                            viewModel.updateProfile()
                        }) {
                            Text("저장하기")
                                .bold()
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    
                    Divider()
                    
                    // --- 알럿 테스트 섹션 ---
                    VStack(spacing: 15) {
                        Text("ReMU 알럿 테스트")
                            .font(.headline)
                        
                        Button("프로필 수정 알럿") {
                            AlertManager.shared.show(.edit { print("수정 로직 실행") })
                        }
                        
                        Button("데이터 삭제", role: .destructive) {
                            AlertManager.shared.show(.delete {
                                AlertManager.shared.show(.confirmDelete { print("최종 삭제") })
                            })
                        }
                        
                        Button("에러 발생 테스트") {
                            AlertManager.shared.showError(message: "네트워크 연결이 불안정합니다.")
                        }
                    }
                    
                    // --- 팀원의 새로운 컴포넌트 예시 (참고용) ---
                    /*
                    PrimaryButton(title: "다음 페이지") {
                        goNext = true
                    }
                    .navigationDestination(isPresented: $goNext) {
                        NextView()
                    }
                    */
                }
                .padding()
            }
            .navigationTitle("프로필 수정")
            // 알럿 기능을 위한 모디파이어
            .modifier(ActionAlertModifier())
        }
    }
}

#Preview {
    ContentView()
}

*/
