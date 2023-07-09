//
//  NetworkTarget.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/21.
//

import Foundation
import UIKit
import Moya

enum NetworkTarget {
    case getUsers
    case createUser(requestData: Users)
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

extension NetworkTarget: TargetType {
    var baseURL: URL {
        return URL(string: "https://gorest.co.in/public/v2")!
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return "/users"
        case .createUser:
            return "/users"
        case let .updateUser(id, _), let .deleteUser(id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUsers:
            return .get
        case .createUser:
            return .post
        case .updateUser:
            return .put
        case .deleteUser:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case let .createUser(users):
            let parameters: [String: Any] = [
                "name": users.name,
                "email": users.email,
                "gender": users.gender,
                "status": users.status
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case let .updateUser(_, name):
            let parameters: [String: Any] = [
                "name": name
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .deleteUser:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json", "Authorization": "Bearer d371c007b72253aa2b63aff5bff6d3ef5ca3410782d42d1e1af760d4c7656f9b"]
    }
}
