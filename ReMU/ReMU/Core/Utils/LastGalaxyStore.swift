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
        let value = UserDefaults.standard.integer(forKey: key)
        return value == 0 ? nil : value
    }
}
