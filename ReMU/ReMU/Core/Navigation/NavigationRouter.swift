//
//  NavigationRouter.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

import Foundation

/// SwiftUI에서 상태를 추적할 수 있도록 Observable로 선언된 라우터 클래스
@Observable
final class NavigationRouter {
    
    /// 현재 네비게이션 스택에 쌓여 있는 목적지들 (화면 전환 상태)
    var destinations: [NavigationRoute] = []
    
    /// homeview가 parentview 인 경우
    /// 가장 먼저 은하만들어야함.
    /// push(createGalaxy)
    /// 사용자 ; 은하생성뷰 이동
    ///var destinations: [NavigationRoute] = [home,createGalaxy]
    
    /// 화면을 새로 추가 (푸시)
    func push(_ destination: NavigationRoute) {
        destinations.append(destination)
    }
    
    /// 마지막 화면을 제거 (뒤로 가기)
    /// if 사용자가 뒤로가기를 누른다.
    /// pop()
    ///  [home,createGalaxy] -> 가장 마지막 원소? 를 삭제합니다.
    ///  자동으로 destination 배열은 [home]
    ///  사용자는 home로 이동
    func pop() {
        _ = destinations.popLast()
    }
    
    /// 스택을 초기화하여 루트 화면으로 이동
    func popToRoot() {
        destinations.removeAll()
    }
    
    /// 목적지 포함 여부
    /// if [initialHomeView, GalaxyHome]
    /// API를 호출했는데 데이터가 있다?(contains) -> galaxyHome이동
    /// 반환 type이 bool true -> 어디로
    /// contains(x) -> destination 배열에 x가 있다면 true -> true라면 homeview로 이동해라
    func contains(_ destination: NavigationRoute) -> Bool {
        destinations.contains(destination)
    }
}
