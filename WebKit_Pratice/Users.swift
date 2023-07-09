//
//  Users.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/05.
//

import Foundation
 
struct Users: Codable {
    let id: Int
    let name: String
    let email: String
    let gender: Gender // male or female
    let status: Status // active or Inactive
}

enum Gender: String, Codable {
    case male = "male"
    case female = "female"
}

enum Status: String, Codable {
    case active = "active"
    case inactive = "inactive"
}
