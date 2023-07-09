//
//  ToNative.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/07/03.
//

import Foundation

struct ToNative: Codable {
    let type: String
    let functionType: String
    let value: Value
    
    struct Value: Codable {
        let data: String
    }
}
