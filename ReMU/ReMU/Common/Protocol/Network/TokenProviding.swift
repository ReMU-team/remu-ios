//
//  TokenProviding.swift
//  ReMU
//
//  Created by 김종수 on 2/1/26.
//

import Foundation

protocol TokenProviding {
    var accessToken: String? { get set }
    var refreshToken: String? { get set }
    func refreshToken(completion: @escaping (String?, Error?) -> Void)
    func isTokenExpiringSoon(buffer: TimeInterval) -> Bool
    func clearSession()

}
extension TokenProviding {
    func isTokenExpiringSoon() -> Bool {
        return isTokenExpiringSoon(buffer: 3000)
    }
}
