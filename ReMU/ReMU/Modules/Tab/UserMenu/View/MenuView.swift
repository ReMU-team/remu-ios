//
//  MenuView.swift
//  ReMU
//
//  Created by 김종수 on 1/15/26.
//

import SwiftUI
import Combine
import Moya

struct MenuView: View {

    @State private var isOn = false
    @StateObject private var viewModel: MenuViewModel
    @Environment(\.dismiss) private var dismiss

    init(container: DIContainer) {
        _viewModel = StateObject(
            wrappedValue: MenuViewModel(
                provider: container.apiProviderStore.user()
            )
        )
    }

    var body: some View {
        VStack(alignment: .leading) {
            
            navigationBar
                .padding(.horizontal, -20)
                .padding(.bottom, 38)
            
            profileView
            
            Divider()
                .background(Color.grayScale9)
                .frame(height: 0.5)
                .padding(.bottom, 24)
            
            Text("설명")
                .font(.pt18)
                .foregroundColor(.grayScale9)
            
            alarmSection
            
            Divider()
                .background(Color.grayScale9)
                .frame(height: 0.5)
                .padding(.bottom, 24)
            
            menuSection
            
            Spacer()
            
            bottomButtons
        }
        .padding(.horizontal, 20)
        .modifier(ActionAlertModifier())
        .task {
            await viewModel.fetchProfile()
        }
    }
        

    // MARK: - Profile
    private var profileView: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
            } else if let profile = viewModel.profile {
                HStack {
                    Image("StandardProfile")
                        .resizable()
                        .frame(width: 56, height: 56)

                    VStack(alignment: .leading, spacing: 16) {
                        Text(profile.name)
                            .font(.pt16)
                            .foregroundColor(.grayScale9)

                        Text(profile.introduction ?? "")
                            .font(.pt13)
                            .foregroundColor(.grayScale7)
                    }
                    .padding(.horizontal, 16)

                    Spacer()

                    Button(action: {}) {
                        Image("pencil.line")
                            .foregroundColor(.grayScale7)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.bottom, 32)
            } else if viewModel.hasError {
                Text("프로필을 불러오지 못했어요")
                    .foregroundColor(.false3)
            }
        }
    }

    // MARK: - Alarm
    private var alarmSection: some View {
        HStack {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(.grayScale9)

            Spacer()

            Toggle("알림 설정", isOn: $isOn)
                .font(.pt16)
                .foregroundColor(.grayScale9)
                .tint(.purpleD9BCEA)
                .onChange(of: isOn) { _, newValue in
                    if newValue {
                        AlertManager.shared.show(.allowAlarm {})
                    }
                }
        }
        .padding(.bottom, 24)
    }

    // MARK: - Menu Section
    private var menuSection: some View {
        VStack(spacing: 24) {
            menuRow(icon: "volume", title: "문의하기")
            menuRow(icon: "home", title: "앱 스토어 리뷰")
            menuRow(icon: nil, title: "앱 버전")
        }
    }

    private func menuRow(icon: String?, title: String) -> some View {
        HStack {
            if let icon {
                Image(icon)
                    .resizable()
                    .frame(width: 24, height: 24)
            } else {
                Color.clear.frame(width: 24, height: 24)
            }

            Text(title)
                .font(.pt16)
                .foregroundColor(.grayScale9)

            Spacer()

            Image("rightArrow")
        }
    }

    // MARK: - Bottom Buttons
    private var bottomButtons: some View {
        VStack(spacing: 24) {
            Button {
                AlertManager.shared.show(.delete {})
            } label: {
                Text("탈퇴하기")
                    .font(.pt16)
                    .foregroundColor(.false3)
            }

            Button {
                AlertManager.shared.show(.logout {})
            } label: {
                Text("로그아웃")
                    .font(.pt16)
                    .foregroundColor(.grayScale9)
            }
        }
    }

    // MARK: - Navigation
    private var navigationBar: some View {
        CustomNavigationBar(
            title: "메뉴",
            onBack: { dismiss() }
        )
    }
}


#Preview {
    MenuView(container: DIContainer.preview)
}


