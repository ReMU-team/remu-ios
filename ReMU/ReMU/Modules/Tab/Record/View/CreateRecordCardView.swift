//
//  CreateRecordCardView.swift
//  ReMU
//
//  Created by 김진서 on 1/15/26.
//

import Foundation
import SwiftUI
import Moya
import _Concurrency

struct CreateRecordCardView: View {
    @EnvironmentObject private var container: DIContainer
    @Environment(\.dismiss) private var dismiss

    let draft: RecordDraft
    let galaxyId: Int
    let dday: Int
    let onFinish: () -> Void

    @StateObject private var viewModel: CreateRecordCardViewModel

    init(
        draft: RecordDraft,
        galaxyId: Int,
        dday: Int,
        onFinish: @escaping () -> Void
    ) {
        self.draft = draft
        self.galaxyId = galaxyId
        self.dday = dday
        self.onFinish = onFinish

        _viewModel = StateObject(
            wrappedValue: CreateRecordCardViewModel.placeholder()
        )
    }

    var body: some View {
        VStack {
            navigationBar
            recordCardView
            finishButton
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.inject(container: container)
        }
    }

    // MARK: - navigationBar
    private var navigationBar: some View {
        CustomNavigationBar(
            title: "기록 생성",
            onBack: { dismiss() }
        )
    }

    // MARK: - recordCardView
    private var recordCardView: some View {
        let recordModel = RecordCardModel.from(
            draft: draft,
            dday: dday
        )

        return VStack {
            Text("기록 카드가 생성되었어요!")
                .font(.pt18)
                .foregroundStyle(.grayScale9)

            RecordCardFlip(model: recordModel)
                .padding(.top, 50)
                .padding(.bottom, 20)

            Text("카드를 클릭하면 뒷면이 보여요!")
                .font(.pt13)
                .foregroundStyle(.grayScale5)
        }
        .padding(.top, 64)
    }

    // MARK: - finishButton
    private var finishButton: some View {
        VStack {
            Spacer()
            PrimaryButton(title: "완료", backgroundColor: .purpleC495E0) {
                _Concurrency.Task {
                    let success = await viewModel.createRecord(
                        galaxyId: galaxyId,
                        draft: draft
                    )

                    if success {
                        onFinish()
                    }
                }
            }
            .disabled(viewModel.isLoading)
            .padding(.bottom, 54)
        }
        .padding(.horizontal, 40)
    }
}
