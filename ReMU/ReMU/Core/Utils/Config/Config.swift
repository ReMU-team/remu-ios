//
//  Config.swift
//  ReMU
//
//  Created by 김종수 on 1/27/26.
//

import Foundation

enum Config{
    
// api 주소 관리
// TODO: api 주소는 xconfig 파일에서 관리하도록 변경 및 error 추가(아래 참고)
//    static let baseURL: String = {
//            guard let baseURL = Config.infoDictionary["BASE_URL"] as? String else {
//                fatalError()
//            }
//            return baseURL
//        }()
    static let baseURL: String = "https://remu-travel.com"
}
