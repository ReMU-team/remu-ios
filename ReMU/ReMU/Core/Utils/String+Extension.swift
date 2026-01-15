//
//  String+Extension.swift
//  ReMU
//
//  Created by 원서우 on 1/15/26.
//

import Foundation

extension String {
    // 문자열을 UTF8 데이터로 변환해주는 도우미
    var utf8Encoded: Data {
        return self.data(using: .utf8) ?? Data()
    }
}
