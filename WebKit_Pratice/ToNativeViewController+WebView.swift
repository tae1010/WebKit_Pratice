//

//  ViewController+WebView.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/23.
//

import Foundation
import UIKit
import WebKit

extension ToNativeViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        print("새로운 창이 열릴때 호출 (새탭)")
        
        let size = webView.frame.size
        let point = webView.frame.origin
        let frame = CGRect(x: point.x, y: point.y, width: size.width, height: size.height)
    
        let newWebView = WKWebView(frame: frame, configuration: configuration)
        newWebView.allowsBackForwardNavigationGestures = true
        view.addSubview(newWebView)
        
        return newWebView
    }
    
    func webViewDidClose(_ webView: WKWebView) {
        print("창이 닫힐때")
    }
    
    //MARK:  탐색 관련
    
    // 웹뷰가 탐색을 시작할 때 수행 (링크 클릭 웹 페이지 변경) (ios 13)
    // 새 콘텐츠로 이동할 수 있는 권한을 요청
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
        print("탐색 시작")
        let pref = preferences
        switch navigationAction.request.url?.scheme {
        case "tel", "mailto":
            UIApplication.shared.open(navigationAction.request.url!, options: [:], completionHandler: nil)
            decisionHandler(.cancel, pref)
            break

        default:
            decisionHandler(.allow, pref)
            break
        }
    }

    // 웹뷰가 탐색을 시작할 때 수행 (링크 클릭 웹 페이지 변경) (ios 8)
//    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
//        decisionHandler(.allow)
//    }
    
    // 네비게이션 응답을 확인하고 필요한 처리를 수행
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("3. 네비게이션 응답 확인")
        decisionHandler(.allow)
    }
    
    
    //MARK: load 관련
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("2. 콘텐츠 탐색 시작")
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        print("웹 페이지 로드 중에 다른 url 호출")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("4. 로딩 (웹 콘텐츠를 수신하기 시작)")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("5. 콘텐츠 로드 완료")
    }
    
    
    //MARK: 인증 관련
    
    // 보안을 설정하기 위해 서버가 클라이언트에게 요구
    // 작성하지 않으면 URLSession.AuthChallengeDisposition.rejectProtectionSpace(인증을 실패로 처리)로 응답 (ex. 서버의 인증서가 신뢰할 수 없는 인증 기관에서 발급한 것이거나, 인증서의 유효 기간이 만료된 경우)
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        //        print("서버가 클라이언트에게 인증을 요청")
        completionHandler(.rejectProtectionSpace, nil)
    }
    
    // 오래된 TLS버전 사용 여부
    func webView(_ webView: WKWebView, authenticationChallenge challenge: URLAuthenticationChallenge, shouldAllowDeprecatedTLS decisionHandler: @escaping (Bool) -> Void) {
        decisionHandler(true)
    }
    
    
    //MARK: 탐색 오류 관련
    
    // 탐색 오류가 발생할 떄(완전히 실패)
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("탐색중 오류가 발생")
    }
    
    // 탐색이 일부만 성공하고 나머지는 실패
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("탐색중 일부 실패")
    }
    
    // 웹 콘텐츠 프로세스가 종료
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        print("웹 콘텐츠 프로세스가 종료")
    }
    
}

