//
//  CreatePledgeCardView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import SwiftUI

struct CreatePledgeCardView: View {
    // 뒤로가기
    @Environment(\.dismiss) private var dismiss
    
    let galaxy: Galaxy
    @ObservedObject var viewModel: PledgeViewModel
    let onFinish: () -> Void
    
    var body: some View {
        VStack{
            navigationBar
            Spacer()
            pledgeCardView
            Spacer()
            finishButton
        }
        .navigationBarBackButtonHidden(true) // 자동 생성되는 뒤로가기 버튼 가리기
    }
    
    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
            title: "다짐 생성",
            onBack: {
                dismiss()
            }
        )
    }
    
    // MARK: - pledgeCardView
    private var pledgeCardView: some View {
        VStack {
            Text("다짐 카드가 생성되었어요!")
                .font(.pt20)
                .foregroundStyle(.grayScale9)
            PledgeCardFlip(
                card: viewModel.makeDraftCard(galaxy: galaxy),
                onEdit: nil   // 생성 화면에서는 수정 버튼 필요 없음
            )
            .padding(.top, 50)
            .padding(.bottom, 20)
            Text("카드를 클릭하면 뒷면이 보여요!")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
        }
    }
    
    // MARK: - finishButton
    private var finishButton: some View {
        VStack {
            PrimaryButton(title: "완료", backgroundColor: .purpleC495E0) {
                viewModel.createPledge(galaxy: galaxy) { result in
                    switch result {
                    case .success:
                        LastGalaxyStore.save(galaxy.serverId) 
                        onFinish()
                    case .failure(let error):
                        print("❌ 다짐 생성 실패:", error.localizedDescription)
                    }
                }
            }

            .padding(.horizontal, 40)
            .padding(.bottom, 54)
        }
        
        
    }
}

#Preview {
    let mockGalaxy = Galaxy(
        serverId: 1,
        title: "경주 여행",
        destination: "경주",
        startDate: Date(),
        endDate: Date().addingTimeInterval(60*60*24*3),
        totalDay: 4,
        galaxyIcon: "galaxy_1",
        stars: []
    )
    
    let mockCard = PledgeCardModel(
        galaxy: mockGalaxy,
        emojiImageName: "amazed_emoji",
        pledges: [
            Pledge(resolutionId: 1, content: "맛있는거 먹기"),
            Pledge(resolutionId: 2, content: "야경 보기")
        ]
    )
    
    NavigationStack {
        VStack {
            PledgeCardFlip(
                card: mockCard,
                onEdit: {}
            )
        }
    }
}





