//
//  ContentView.swift
//  ReMU
//
//  Created by 김진서 on 1/9/26.
//

import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                VStack(spacing: 30) {
                    // 컴포넌트 적용
                    ProfileImage(
                        selectedImageData: $viewModel.selectedImageData)
                    
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
                    .padding()
                    
                    Spacer()
                }
                .navigationTitle("프로필 수정")
                .padding(.top, 50)
                
                // 예시 1: 수정 알럿
                Button("프로필 수정") {
                    AlertManager.shared.show(.edit {
                        print("수정 로직 실행됨")
                    })
                }
                
                // 예시 2: 삭제 알럿 (연쇄 알럿)
                Button("데이터 삭제", role: .destructive) {
                    AlertManager.shared.show(.delete {
                        print("1차 삭제 확인")
                        // 삭제 성공 후 완료 알럿 띄우기
                        AlertManager.shared.show(.confirmDelete {
                            print("최종 삭제 완료")
                        })
                    })
                }
                
                // 예시 3: 에러 알럿
                Button("에러 발생 테스트") {
                    AlertManager.shared.showError(message: "네트워크 연결이 불안정합니다.")
                }
                
                // 예시 4: 커스텀 버튼 텍스트 확인 (은하 만들기)
                Button("은하 만들기") {
                    AlertManager.shared.show(.makeGalxy {
                        print("은하 생성 페이지로 이동")
                    })
                }
                Button("알림 설정") {
                    AlertManager.shared.show(.allowAlarm {
                        print("알림 설정")
                    })
                }
            }
            .padding()
            .navigationTitle("ReMU 알럿 테스트")
            // 뷰의 최상단에 Modifier를 적용합니다.
            .modifier(ActionAlertModifier())
        }
    }
}

#Preview {
    ContentView()
}
