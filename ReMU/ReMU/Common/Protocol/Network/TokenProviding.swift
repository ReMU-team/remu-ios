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
}
