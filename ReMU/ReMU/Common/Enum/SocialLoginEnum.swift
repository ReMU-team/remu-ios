//
//  SocialLoginEnum.swift
//  ReMU
//
//  Created by 김진서 on 1/13/26.
//

import Foundation
import SwiftUI

enum SocialLoginType {
    case kakao
    case google
    case apple

    var title: String {
        switch self {
        case .kakao: return "카카오로 시작하기"
        case .google: return "Google로 시작하기"
        case .apple:  return "Apple로 시작하기"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .kakao: return .yellowKakao
        case .google: return .white
        case .apple: return .grayScale9
        }
    }

    var textColor: Color {
        switch self {
        case .kakao: return .grayScale9
        case .google: return .grayScale9
        case .apple: return .white
        }
    }

    var borderColor: Color? {
        switch self {
        case .google: return .grayScale8
        default: return nil
        }
    }

    var iconName: String {
        switch self {
        case .kakao: return "kakao_icon"
        case .google: return "google_icon"
        case .apple: return "apple_icon"
        }
    }
    
    var iconTextSpacing: CGFloat {
            switch self {
            case .kakao: return 8
            case .google, .apple: return 4
            }
        }
}
