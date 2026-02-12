//
//  LastGalaxyStore.swift
//  ReMU
//
//  Created by 김진서 on 2/11/26.
//

import Foundation

enum LastGalaxyStore {
    private static let key = "lastGalaxyId"

    static func save(_ id: Int) {
        UserDefaults.standard.set(id, forKey: key)
    }

    static func load() -> Int? {
        UserDefaults.standard.object(forKey: key) as? Int
    }

    static func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

