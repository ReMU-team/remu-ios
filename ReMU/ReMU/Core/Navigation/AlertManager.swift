//
//  AlertManager.swift
//  ReMU
//
//  Created by 김종수 on 1/11/26.
//

// Core/Navigation/AlertManager.swift

import Foundation

@MainActor
@Observable
class AlertManager {
    static let shared = AlertManager()
    private init() {}

    var isShowingAlert = false
    
    // 현재 어떤 알럿이 떠야 하는지를 저장하는 단일 원천(Source of Truth)
    private(set) var activeAlert: ActionAlertType?

    // Enum을 주입받는 통일된 메서드
    func show(_ type: ActionAlertType) {
        self.activeAlert = type
        self.isShowingAlert = true
    }
    
    // Error 처리를 위한 편의 메서드
    func showError(title: String = "에러", message: String) {
        show(.error(title: title, message: message))
    }

    func dismiss() {
        isShowingAlert = false
        // 애니메이션을 위해 약간의 딜레이 후 nil 처리하는 것이 좋습니다.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.activeAlert = nil
        }
    }
}
