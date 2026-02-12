//
//  CardOverlayView.swift
//  ReMU
//
//  Created by 김진서 on 2/3/26.
//

import SwiftUI

struct CardOverlayView: View {
    @EnvironmentObject var container: DIContainer
    @Binding var selectedTab: CardTab
    
    let pledgeCard: PledgeCardModel?
    let onClose: () -> Void
    let onWriteResult: () -> Void
    let onEdit: () -> Void

    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                header
                ZStack {
                    content
                }
                .frame(width: CardSize.width, height: CardSize.height)
                Text("카드를 터치하면 뒷면이 보여요")
                    .font(.pt15)
                    .foregroundStyle(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture { } // 닫힘 방지
        }
        .task {
            if let serverId = pledgeCard?.galaxy.serverId {
                print("✅ [CardOverlayView] DIContainer를 통해 GalaxyID(\(serverId)) 저장 완료")
                container.appState.currentGalaxyId = serverId
            } else {
                print("⚠️ [CardOverlayView] pledgeCard가 없거나 serverId를 찾을 수 없음")
            }
        }
    }
    
    // MARK: - header
    private var header: some View {
        HStack(spacing: 12) {
            tabButton(title: "다짐 카드", tab: .pledge)
            tabButton(title: "회고 카드", tab: .review)
        }
    }
    
    // MARK: - tabButton
    private func tabButton(title: String, tab: CardTab) -> some View {
        Button {
            withAnimation {
                selectedTab = tab
            }
        } label: {
            Text(title)
                .font(.pt12)
                .frame(height: 30)
                .frame(width: 130)
                .foregroundStyle(.white)
                .glassEffect(.clear.interactive(), in: .capsule)
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch selectedTab {
            
        case .pledge:
            if let pledgeCard {
                PledgeCardFlip(
                    card: pledgeCard,
                    onEdit: onEdit
                )

            } else {
                Text("다짐 카드가 없습니다")
                    .foregroundStyle(.white)
            }
            
        case .review:
            ReviewCardGuideView{
                onWriteResult()
            }
        }
    }
    
    
    // MARK: - ReviewCardGuideView
    struct ReviewCardGuideView: View {
        let onWriteResult: () -> Void
        var body: some View {
            ZStack {
                Rectangle()
                    .fill(.white)
                    .cornerRadius(16)
                    .shadow(radius: 8)
                VStack {
                    top
                    Spacer()
                    middle
                        .padding(.bottom, 68)
                    
                    
                }
                .padding(.horizontal, 24)
            }
            .frame(width: CardSize.width, height: 430)
        }
        
        var top: some View {
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Spacer()
                        Button(action: {}) {
                            Image("close_icon")
                                .foregroundStyle(Color.grayScale8)
                        }
                    }
                }
            }
            .padding(.top, 32)
            .padding(.bottom, 22)
        }
        
        var middle: some View {
            VStack (spacing: 56) {
                VStack (spacing: 18){
                    Image("card_star_icon")
                    Text("아직 여행이 끝나지 않았어요")
                        .font(.pt15)
                        .foregroundStyle(.blue212148)
                }
                
                Text("다짐과 기록으로 은하를 채운 뒤,\n여행에 대한 회고와 나만을 위한 \nAI 회고록을 받아봐요")
                    .font(.pt13)
                    .foregroundStyle(.blue212148)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                
                VStack (spacing: 12) {
                    Button {
                        onWriteResult()
                        
                    } label: {
                        Text("회고 카드 만들기")
                            .font(.pt12)
                            .foregroundStyle(.purpleC495E0)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .frame(height: 24, alignment: .center)
                            .overlay(
                                RoundedRectangle(cornerRadius: 26)
                                    .stroke(.purpleC495E0)
                            )
                    }
                    
                    Text("회고 카드를 만들면 여행이 종료돼요")
                        .font(.pt12) //TODO: pt10
                        .foregroundStyle(.grayScale5)
                }
            }
        }
    }


}


// MARK: - Preview
#Preview {
    CardOverlayPreview()
}

private struct CardOverlayPreview: View {
    @State private var selectedTab: CardTab = .pledge

    private var mockGalaxy: Galaxy {
        Galaxy(
            serverId: 1,
            title: "경주 여행",
            destination: "경주",
            startDate: Date(),
            endDate: Date().addingTimeInterval(60*60*24*3),
            totalDay: 4,
            galaxyIcon: "galaxy_1",
            stars: []
        )
    }

    private var mockCard: PledgeCardModel {
        PledgeCardModel(
            galaxy: mockGalaxy,
            emojiImageName: "emoji_1",
            pledges: [
                Pledge(resolutionId: 1, content: "외국인이랑 스몰토킹하기"),
                Pledge(resolutionId: 2, content: "현지인 맛집 가보기")
            ]

        )
    }

    var body: some View {
        ZStack {
            Color.blue212148
                .ignoresSafeArea()

            CardOverlayView(
                selectedTab: $selectedTab,
                pledgeCard: mockCard,
                onClose: { print("닫기 눌림") },
                onWriteResult: {},
                onEdit: { print("수정 눌림") }
            )

        }
    }
}
