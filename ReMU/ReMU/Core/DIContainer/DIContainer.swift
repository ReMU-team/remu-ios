//
//  DIContainer.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

/// HomeView가 Parent라면
/// 얘는 자식
/// 자식이 가장이되는 느낌?
/// 부모님이 정보를 아래로 전달해야하는데
/// 자식이 정보를 중간에서 만들어버립니다.
/// 홈뷰 -> 회고카드 작성 뷰 -> 뷰모델 초기화 -> 뒤로가기 -> 다시 회고카드 작성 뷰 -> 다시 뷰모델 초기화
/// DIcontainer라는 걸로 부모뷰에서 모든걸 주입시켜줌
/// 자식 뷰에서 회고 카드 기록 작성할꺼니까 데이터 내놔 하면 부모뷰에서 전달
/// 싱글톤패턴
/// class 당 인스턴스는 한개만 가지는
/// 뷰를 렌더링? 호출할 때맏 ㅏ인스턴스를 만들어버리는 것은 안좋다.
/// 그래서 DIContainer 한번만 초기화 하면 이걸로 유지하는 느낌?
///외부적으로 봤을 때는 문제없지만
///내부적으로는 꼬일 수 있어서
///정리하기 위해서 작성한 코드들
import Foundation
import Combine

final class DIContainer: ObservableObject{
    @Published var router: NavigationRouter
    let userSessionKeychain: UserSessionKeychainService
    
    init(
        router: NavigationRouter = .init(),
        userSessionKeychain: UserSessionKeychainService = UserSessionKeychainServiceImpl()
    ) {
        self.router = router
        self.userSessionKeychain = userSessionKeychain
    }
}

/// 
