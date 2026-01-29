//
//  DIContainer.swift
//  ReMU
//
//  Created by 김종수 on 1/28/26.
//

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
