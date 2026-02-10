//
//  UserSessionKeychainServicelmpl.swift
//  ReMU
//
//  Created by 김종수 on 1/29/26.
//

import Foundation
import Security

final class UserSessionKeychainServiceImpl: UserSessionKeychainService {
    static let shared = UserSessionKeychainServiceImpl()
    let manager: KeychainManager
    
    init(manager: KeychainManager = .shared) {
        self.manager = manager
    }
    
    func saveSession(_ session: UserInfo, for key: KeychainKey) -> Bool {
        guard let data = try? JSONEncoder().encode(session) else { return false }
        return manager.save(data, for: key.rawValue)
    }
    
    func loadSession(for key: KeychainKey) -> UserInfo? {
        guard let data = manager.load(key: key.rawValue),
              let session = try? JSONDecoder().decode(UserInfo.self, from: data) else { return nil }
        return session
    }
    
    func deleteSession(for key: KeychainKey) {
        _ = manager.delete(key: key.rawValue)
    }
}
