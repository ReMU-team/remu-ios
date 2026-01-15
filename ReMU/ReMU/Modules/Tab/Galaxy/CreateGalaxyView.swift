//
//  CreateGalaxyView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct CreateGalaxyView: View {
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 장소 관련 TODO: 뷰모델 생성 후 수정 예정
    @State private var destination: String?
    @State private var showPlaceSearch = false
    
    // 캘린더 관련 TODO: 뷰모델 생성 후 수정 예정
    @State private var showCalendar = false
    @State private var startDate: Date?
    @State private var endDate: Date?
    
    // 은하 이름 TODO: 뷰모델 생성 후 수정 예정
    @State private var galaxyName: String = ""
    
    // 완료 버튼
    @State private var goNext = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                navigationBar
                Group {
                    writeGalaxy
                    Spacer()
                    galaxyImageSelection
                }
                .padding(.horizontal, 22)
                Spacer()
                finishButton
            }
        }
        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        VStack {
            CustomNavigationBar(
                title: "여행 은하 생성",
                onBack: {
                    dismiss() // 뒤로가기 (home)
                }
            )
            .padding(.top, 11)
            .padding(.bottom, 48)
            
        }
    }
    
    // MARK: - writeGalaxy
    private var writeGalaxy: some View {
        VStack (alignment: .leading, spacing: 24) {
            // 장소 선택
            InputSelectRow(
                title: "어디로 떠날까요?",
                value: destination,
                placeholder: "클릭하여 장소를 검색해주세요"
            ) {
                showPlaceSearch = true
            }
            .sheet(isPresented: $showPlaceSearch) {
                PlaceSearchSheet(
                    selectedPlace: $destination
                )
            }
            
            // 여행 기간 선택
            InputSelectRow(
                title: "언제 떠날까요?",
                value: dateRangeText(start: startDate, end: endDate),
                placeholder: "클릭하여 날짜를 입력해주세요"
            ) {
                showCalendar = true
            }
            .sheet(isPresented: $showCalendar) {
                CalendarSheet(
                    startDate: $startDate,
                    endDate: $endDate
                )
            }
            
            // 은하 이름 입력칸
            Text("은하의 이름을 입력해주세요")
                .font(.pt18)
                .foregroundStyle(.grayScale9)
            ReMUTextField(placeholder: "이름을 입력해주세요", text: $galaxyName)
                .padding(.top, -15) // TODO: 텍스트 필드 패딩 값 설정 필요
            
            
        }
    }
    
    // MARK: - 은하 이미지 선택
    private var galaxyImageSelection: some View {
        VStack (alignment: .leading) {
            Text("당신의 은하는 어떤 모습인가요?")
                .font(.pt18)
                .foregroundStyle(.grayScale9)
            Text("은하 이미지")
                .frame(maxWidth: .infinity, minHeight: 162, maxHeight: 162, alignment: .center)
                .background(Color(red: 0.31, green: 0.31, blue: 0.51))

                .cornerRadius(12)
        }
    }
    
    // MARK: - 완료 버튼
    private var finishButton: some View {
        VStack {
            PrimaryButton(title: "완료", backgroundColor: .purpleC495E0)
            {
                goNext = true
            }
            .navigationDestination(isPresented: $goNext) {
                WritePledgeView() // TODO: 메인으로 변경 필요
            }
        }
        .padding(.horizontal, 40)
    }
        
}
#Preview {
    CreateGalaxyView()
}
