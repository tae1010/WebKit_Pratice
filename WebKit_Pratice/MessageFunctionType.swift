//
//  MessageFunctionType.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/29.
//

import Foundation

protocol FunctionHandler {
    func printValue(_ valueData: String)
}

enum FunctionType: String {
    case shareData = "shareData"
    case browsing = "browsing"
    case systemBrowsing = "systemBrowsing"
    case popup = "popup"
    case certificationResult = "certificationResult"
    case screen = "screen"
    // case 추가
}

enum FunctionHandlerFactory {
    static func createHandler(functionType: FunctionType) -> FunctionHandler? {
        switch functionType {
        case .shareData:
            return ShareDataHandler()
        case .browsing:
            return BrowsingHandler()
        case .systemBrowsing:
            return SystemBrowsingHandler()
        case .popup:
            return PopupHandler()
        case .certificationResult:
            return CertificationResultHandler()
        case .screen:
            return ScreenHandler()
        default:
            return nil
        }
    }
}


class ShareDataHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("\(valueData)")
    }
}

class BrowsingHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("\(valueData)")
    }
}

class SystemBrowsingHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("\(valueData)")
    }
}

class PopupHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("\(valueData)")
    }
}

class CertificationResultHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("\(valueData)")
    }
}

class ScreenHandler: FunctionHandler {
    func printValue(_ valueData: String) {
        print("Handling shareData: \(valueData)")
    }
}

