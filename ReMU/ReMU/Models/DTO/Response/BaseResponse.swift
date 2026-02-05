//
//  BaseResponse.swift
//  ReMU
//
//  Created by 김종수 on 2/4/26.
//

import Foundation

// 공통 응답 구조체 (모든 API에서 재사용)
struct BaseResponse<T: Decodable>: Decodable {
    let isSuccess: Bool
    let code: String
    let message: String
    let result: T? // API마다 달라지는 결과 데이터를 담는 제네릭 타입
}
