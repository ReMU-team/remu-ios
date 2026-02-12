//
//  ActionAlertModifier.swift
//  ReMU
//
//  Created by 김종수 on 1/12/26.
//

import Foundation
import SwiftUI

struct ActionAlertModifier: ViewModifier {
    @Bindable var manager = AlertManager.shared

    func body(content: Content) -> some View {
        content
            .alert(
                manager.activeAlert?.title ?? "",
                isPresented: $manager.isShowingAlert,
                presenting: manager.activeAlert
            ) { type in
                // 1. 확인 버튼 동작 정의
                Button(type.confirmText, role: getRole(for: type)) {
                    executeAction(for: type)
                }
                
                // 2. 취소 버튼 (필요한 경우에만)
                if !isSingleButton(for: type) {
                    Button(type.BackText, role: .cancel) { }
                }
            } message: { type in
                if let msg = type.message {
                    Text(msg)
                }
            }
    }

    // 비즈니스 로직 실행
    private func executeAction(for type: ActionAlertType) {
        switch type {
        case .allowAlarm(let action), .edit(let action), .delete(let action),
                     .redelete(let action), .logout(let action), .goBack(let action),
                     .confirmDelete(let action), .makeGalxy(let action):
                    action()
        default: break
        }
    }

    private func getRole(for type: ActionAlertType) -> ButtonRole? {
        switch type {
        case .delete, .redelete, .logout, .withdraw: return .destructive
        default: return nil
        }
    }

    private func isSingleButton(for type: ActionAlertType) -> Bool {
        switch type {
        case .confirmDelete, .error: return true
        default: return false
        }
    }
}
