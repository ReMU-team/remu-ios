//
//  CreateGalaxyView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct CreateGalaxyView: View {
    // 홈 상태
    @EnvironmentObject var appState: AppState
    
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    // 네비게이션
    @State private var showWritePledge = false
    
    // 은하 생성
    let onFinish: (Galaxy) -> Void
    
    // 뷰모델
    @StateObject private var viewModel = CreateGalaxyViewModel()
    
    var body: some View {
        VStack {
            navigationBar
            Group {
                writeGalaxy
                Spacer()
                galaxyImageSelection
                Spacer()
            }
            .padding(.horizontal, 22)
            
            finishButton
        }
        .fullScreenCover(isPresented: $showWritePledge) {
            NavigationStack {
                WritePledgeView(
                    onFinish: {
                        if let galaxy = viewModel.createdGalaxy {
                            onFinish(galaxy)        // HomeView로 전달
                        }
                        showWritePledge = false
                        dismiss()                  // CreateGalaxyView 닫기
                    }
                )
            }
        }


        
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        VStack {
            CustomNavigationBar(
                title: "은하 생성",
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
                value: viewModel.destination,
                placeholder: "클릭하여 장소를 검색해주세요"
            ) {
                viewModel.showPlaceSearch = true
            }
            .sheet(isPresented: $viewModel.showPlaceSearch) {
                PlaceSearchSheet(
                    selectedPlace: $viewModel.destination
                )
            }
            
            // 여행 기간 선택
            InputSelectRow(
                title: "언제 떠날까요?",
                value: dateRangeText(
                    start: viewModel.startDate,
                    end: viewModel.endDate
                ),
                placeholder: "클릭하여 날짜를 입력해주세요"
            ) {
                viewModel.showCalendar = true
            }
            .sheet(isPresented: $viewModel.showCalendar) {
                CalendarSheet(
                    startDate: $viewModel.startDate,
                    endDate: $viewModel.endDate
                )
            }
            
            // 은하 이름 입력칸
            Text("은하의 이름을 입력해주세요")
                .font(.pt18)
                .foregroundStyle(.grayScale9)
            ReMUTextField(text: $viewModel.galaxyName,
                          placeholder: "이름을 입력해주세요", height: 46)
                .padding(.top, -15) // TODO: 텍스트 필드 패딩 값 설정 필요
            
            
        }
    }
    
    // MARK: - 은하 이미지 선택
    private let galaxies = GalaxyImageCatalog.all

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 16),
        count: 5
    )
    
    private var galaxyImageSelection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("당신의 은하는 어떤 모습인가요?")
                .font(.pt18)
                .foregroundStyle(.grayScale9)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(galaxies) { galaxy in
                    GalaxySelectableItem(
                        galaxy: galaxy,
                        isSelected: viewModel.selectedGalaxyImageName == galaxy.id
                    )
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                            viewModel.selectedGalaxyImageName = galaxy.id
                        }
                    }
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 162, maxHeight: 162, alignment: .top)
            .background(.blue505083)
            .cornerRadius(12)
            
            
        }
    }
    
    // MARK: - 완료 버튼
    private var finishButton: some View {
        VStack {
            PrimaryButton(title: "완료",
                          backgroundColor: viewModel.isFinishEnabled ? .purpleC495E0 : .grayScale3,
                          isDisabled: !viewModel.isFinishEnabled
            ) {
                let galaxy = viewModel.makeGalaxy()
                viewModel.createdGalaxy = galaxy // 임시 저장
                showWritePledge = true // 다짐 작성으로 이동
            }
        }
        .padding(.horizontal, 40)
    }
}


struct GalaxySelectableItem: View {

    let galaxy: GalaxyImageItem
    let isSelected: Bool

    var body: some View {
        Image(galaxy.id)
            .resizable()
            .frame(
                width: isSelected ? 80 : 65,
                height: isSelected ? 80 : 65
            )
            .scaleEffect(isSelected ? 1.15 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}


//
//#Preview {
//    CreateGalaxyView()
//}
