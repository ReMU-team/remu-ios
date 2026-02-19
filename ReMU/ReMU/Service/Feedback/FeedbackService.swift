//
//  FeedbackService.swift
//  ReMU
//
//  Created by 원서우 on 2/10/26.
//

import Foundation

protocol FeedbackServiceProtocol {

    func createFeedback(
        galaxyId: Int,
        completion: @escaping (Result<FeedbackResponse, Error>) -> Void
    )

    func fetchFeedback(
        galaxyId: Int,
        completion: @escaping (Result<FeedbackResponse, Error>) -> Void
    )

    func patchFeedback(
        galaxyId: Int,
        completion: @escaping (Result<PatchFeedbackResponse, Error>) -> Void
    )
}

