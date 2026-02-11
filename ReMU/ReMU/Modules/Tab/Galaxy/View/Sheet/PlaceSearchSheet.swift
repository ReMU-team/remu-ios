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
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(Color.gray)

                TextField("장소를 검색하세요", text: $keyword)
                    .font(.pt16)

                if !keyword.isEmpty {
                    Button {
                        keyword = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(Color.gray)
                    }
                }
            }
            .padding(12)
            .background(Color.grayScale2)
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .padding(.top, 20)

            // 장소 리스트
            List(filteredPlaces, id: \.self) { place in
                Button {
                    selectedPlace = place
                    dismiss()
                } label: {
                    Text(place)
                        .font(.pt16)
                        .foregroundStyle(Color.primary)
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


