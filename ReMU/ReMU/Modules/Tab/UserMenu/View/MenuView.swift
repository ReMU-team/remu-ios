//
//  MenuView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import SwiftUI

struct MenuView: View {
    @State private var isOn = false
    
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading){
            navigationBar
                .padding(.horizontal, -20)
                .padding(.bottom, 38)
            
            // MARK: - 프로필
            HStack{
                Image("StandardProfile")
                
                VStack(alignment: .leading, spacing: 16){
                    Text("계정 이름")// 수정필요
                        .font(.pt16)
                        .foregroundColor(.grayScale9)
                    Text("한 줄 소개") // 수정필요
                        .font(.pt13)
                        .foregroundColor(.grayScale7)
                }
                .padding(.horizontal, 16)
                Spacer()
                
                // 프로필 수정하기 버튼
                Button(action:{}){
                    Image("pencil.line")
                        .foregroundColor(.grayScale7)
                }
                    
            }.padding(.horizontal,12)
                .padding(.bottom,32)
            Divider()
                .background(Color.grayScale9) // 선 색상 조절
                .frame(height: 0.5)
                .padding(.bottom,24)
            Text("설명")
                .font(.pt18)
                .foregroundColor(.grayScale9)
            HStack{
                Image(systemName: "bell")
                    .resizable()
                    .foregroundColor(.grayScale9)
                    .frame(width: 24,height: 24)

                Spacer()
                Toggle("알림 설정",isOn: $isOn)
                    .font(.pt16)
                    .foregroundColor(.grayScale9)
                    .tint(.purpleD9BCEA)
                    .onChange(of: isOn) { oldValue,newValue in
                        if newValue { // 토글이 켜졌을 때만 알럿 띄우기
                            AlertManager.shared.show(.allowAlarm {
                                print("알림 설정 로직 실행")
                                // 확인 버튼을 눌렀을 때 수행할 작업
                            }
                            )
                        }
                    }
                
            }.padding(.bottom,24)
            Divider()
                .background(Color.grayScale9) // 선 색상 조절
                .frame(height: 0.5)
                .padding(.bottom,24)
            VStack(spacing: 24){
                HStack{
                    Image("volume")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.grayScale9)
                    Text("문의하기")
                        .font(.pt16)
                        .foregroundColor(.grayScale9)
                    Spacer()
                    Button(action:{}){
                        Image("rightArrow")
                            .foregroundColor(.grayScale9)
                    }
                }
                HStack{
                    Image("home")
                        .resizable()
                        .frame(width: 24,height: 24)
                        .foregroundColor(.grayScale9)
                    Text("앱 스토어 리뷰")
                        .font(.pt16)
                        .foregroundColor(.grayScale9)
                    Spacer()
                    Button(action:{}){
                        Image("rightArrow")
                            .foregroundColor(.grayScale9)
                    }
                }
                HStack{
                    Color.clear
                        .frame(width: 24, height: 24)
                    Text("앱 버전")
                        .font(.pt16)
                        .foregroundColor(.grayScale9)
                    Spacer()
                    Button(action:{}){
                        Image("rightArrow")
                            .foregroundColor(.grayScale9)
                    }
                }
            }
            Spacer()
            VStack(alignment:.center, spacing: 24){
                Button(action:{
                    AlertManager.shared.show(.delete {
                        // 확인 버튼을 눌렀을 때 수행할 작업
                    })
                }){
                    Text("탈퇴하기")
                        .font(.pt16)
                        .foregroundColor(.false3)
                }.frame(maxWidth: .infinity)
                
                Button(action:{
                    AlertManager.shared.show(.logout {
                        // 확인 버튼을 눌렀을 때 수행할 작업
                    })
                }){
                    Text("로그아웃")
                        .font(.pt16)
                        .foregroundColor(.grayScale9)
                }
            }
            
        }
        .padding(.horizontal,20)
        .modifier(ActionAlertModifier())
    }
    
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
                        title: "메뉴",
                        onBack: {
                            dismiss()
                        }
                    )
    }
    
}

#Preview {
    MenuView()
}
