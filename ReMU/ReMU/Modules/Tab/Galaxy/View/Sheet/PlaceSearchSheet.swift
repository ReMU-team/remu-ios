//
//  PlaceSearchSheet.swift
//  ReMU
//
//  Created by 김진서 on 1/11/26.
//

import SwiftUI

struct PlaceSearchSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedPlace: String?

    @State private var keyword: String = ""

    // 지금은 mock 데이터 @StateObject private var viewModel = PlaceSearchViewModel() <- 나중에 API 연결 이렇게
    // viewModel.search(keyword), viewModel.places
    private let mockPlaces = [
        "스위스",
        "프랑스",
        "이탈리아",
        "경주, 대한민국",
        "도쿄, 일본",
        "오사카, 일본",
        "타이베이, 대만"
    ]

    var body: some View {
        VStack(spacing: 16) {

            // 검색창
            HStack(spacing: 8) {

                // 검색 텍스트 영역
                HStack(spacing: 6) {
                    TextField("클릭하여 장소를 검색해주세요", text: $keyword)
                        .font(.pt16)
                        .foregroundStyle(.purpleC495E0)
                    
                    if !keyword.isEmpty {
                        Button {
                            keyword = ""
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundColor(.grayScale5)
                        }
                    }
                    // 오른쪽 돋보기 버튼
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.blue212148)
                }
                .padding(.horizontal, 14)
                .padding(.vertical, 10)
                .background(Color.purpleD9BCEA.opacity(0.5))
                .cornerRadius(20)

                
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)


            // 장소 리스트
            List(filteredPlaces, id: \.self) { place in
                Button {
                    selectedPlace = place
                    dismiss()
                } label: {
                    Text(place)
                        .font(.pt16)
                        .foregroundStyle(.black)
                }
            }
            .listStyle(.plain)

            Spacer()
        }
    }

    // MARK: - 검색 결과 필터
    private var filteredPlaces: [String] {
        guard !keyword.isEmpty else { return mockPlaces }
        return mockPlaces.filter {
            $0.localizedCaseInsensitiveContains(keyword)
        }
    }
}


