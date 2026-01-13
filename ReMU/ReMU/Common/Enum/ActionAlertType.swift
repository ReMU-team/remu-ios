//
//  ActionAlertType.swift
//  ReMU
//
//  Created by 김종수 on 1/10/26.
//

import Foundation

enum ActionAlertType {
    case allowAlarm(onConfirm: () -> Void)
    case edit(onConfirm: () -> Void)
    case delete(onConfirm: () -> Void)
    case redelete(onConfirm: () -> Void)
    case confirmDelete(onConfirm: () -> Void)
    case logout(onConfirm: () -> Void)
    case makeGalxy(onConfirm: () -> Void)
    case goBack(onConfirm: () -> Void)
    case error(title: String = "Error", message: String)
    
    var title: String {
        switch self {
        case .allowAlarm : return "'ReMU'에서 알림을 보내고자 합니다."
        case .edit : return "수정하시겠습니까?"
        case .delete : return "삭제하시겠습니까?"
        case .redelete : return "정말 삭제하시겠습니까?"
        case .confirmDelete : return "삭제되었습니다."
        case .logout : return "로그아웃 하시겠습니까?"
        case .makeGalxy : return "아직 은하가 만들어지지 않았네요."
        case .goBack : return "정말 돌아가시겠습니까?"
        case .error(let title, _): return title
        }
        
    }
    var message: String? {
        switch self {
        case .allowAlarm : return "경고, 사운드 및 아이콘 배치가 알림에 포함될 수 있습니다. 설정에서 이를 구성할 수 있습니다."
        case .makeGalxy : return " 여행을 생성한 뒤에 목표를 설정할 수 있어요!"
        case .error(_, let message): return message
        default : return nil
            
        }
    }
    var confirmText: String {
        switch self {
        case .allowAlarm : return "허용"
        case .edit : return "수정하기"
        case .delete : return "삭제하기"
        case .redelete : return "삭제하기"
        case .makeGalxy : return "은하 만들러 가기"
        case .goBack : return "나가기"
        default : return "확인"
        }
    }
    var BackText: String {
        switch self {
        case .allowAlarm : return "허용 안 함"
        case .delete : return "돌아가기"
        case .makeGalxy : return "나중에 할래요"
        case .goBack : return "돌아가기"
        default : return "취소"
            
        }
    }
}
