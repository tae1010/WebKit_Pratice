//
//  ViewController.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/05.
//

/*
 웹 페이지 로딩과정
 1. 사용자가 링크나 url을 입력하는 Action으로 시작(탐색 시작)
 2. 서버에서 처리를 마치고 네트워크를 통해 response를 사용자의 브라우저로 전송 (response 시작)
 3. 사용자가 response를 수신
 4. 렌더링
 */

import UIKit
import WebKit

class ViewController: UIViewController {

    let serverUrl = Bundle.main.object(forInfoDictionaryKey: "serverURL")
    var webView: WKWebView!

    override func loadView() {
//        if let url = Bundle.main.object(forInfoDictionaryKey: "SERVER_URL")
        
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(serverUrl)
        guard let url = URL(string: serverUrl as? String ?? "") else { return }
        let urlRequest = URLRequest(url: url)
        self.webView.load(urlRequest)
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        // webkit의 네이티브 지원 여부 반환
//        print(WKWebView.handlesURLScheme(urlString))
        
    }
}
