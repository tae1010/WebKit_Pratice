//
//  ToNativeViewController.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/26.
//

import Foundation
import UIKit
import WebKit

class ToNativeViewController: UIViewController, WKScriptMessageHandler {
    
    var htmlWebView: WKWebView!
    let urlString = "https://dev1.lemonhc.com/store/test/tonative/ToNative.html"
    
    override func loadView() {
        super.loadView()
        
        let webConfiguration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        
        webConfiguration.applicationNameForUserAgent = "iPhone"
        
        userContentController.add(self, name: "observer")
        webConfiguration.userContentController = userContentController
        htmlWebView = WKWebView(frame: .zero, configuration: webConfiguration)
        view = htmlWebView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: urlString) {
            let urlRequest = URLRequest(url: url)
            self.htmlWebView.load(urlRequest)
        }
        
        htmlWebView.uiDelegate = self
        htmlWebView.navigationDelegate = self
    }
    
    // WKScriptMessageHandler 프로토콜 구현
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("javascript interface 공유 \(message)")
        
        guard let messageBody = message.body as? [String: String] else { return }
        guard let toNativeData = messageBody["toNative"]?.data(using: .utf8) else { return }
        
        do {
            let decoder = JSONDecoder()
            let toNativeData = try decoder.decode(ToNative.self, from: toNativeData)

            let functionType = toNativeData.functionType
            let valueData = toNativeData.value.data
            
            if let handler = FunctionHandlerFactory.createHandler(functionType: FunctionType(rawValue: functionType)!) {
                handler.printValue(valueData)
            } else {
                print("fail")
            }
        } catch {
            print("decoding 오류")
        }
    }
}
