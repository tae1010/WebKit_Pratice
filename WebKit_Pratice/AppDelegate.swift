//
//  AppDelegate.swift
//  WebKit_Pratice
//
//  Created by 손인호 on 2023/06/05.
//

import UIKit
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UNUserNotificationCenter.current().delegate = self
        
        // notification의 세팅값 검색
        UNUserNotificationCenter.current().getNotificationSettings() { setting in
            print("세팅값 검색", setting)
        }
        
        UNUserNotificationCenter.current().getDeliveredNotifications(completionHandler: { noti in
//            print(noti)
            
        })

        
        
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){ granted, error in
            print("asdasd")
            DispatchQueue.main.async {
                if granted {
                    print("권한")
                    application.registerForRemoteNotifications() // 메인 스레드에서 해줘야함 (권한 요청 메서드)
                }
                if let error = error {
                    print(error)
                }
            }
        }
        
        
        
        UNUserNotificationCenter.current().setBadgeCount(1) { error in
            if let error = error {
                print(error)
            }
        }
        
    
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        var token: String = ""
        for i in 0..<deviceToken.count {
            token += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }

        print("토큰", token)
    }

    


    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // 푸시 알림의 내용 확인
        if let aps = userInfo["aps"] as? [String: Any] {
            // "content-available" 값이 1인지 확인하여 새로운 콘텐츠를 가져오는 작업 수행
            if let contentAvailable = aps["content-available"] as? Int, contentAvailable == 1 {
                // 새로운 콘텐츠를 가져오는 작업 수행
                // 예: 데이터 다운로드, 백그라운드 동기화 등
                print("asdsd")
                // 작업이 완료되면 앱의 상태를 업데이트하거나 콘텐츠를 처리할 수 있음

                // 필요에 따라 앱을 깨우고 UI를 업데이트하는 등의 추가 작업을 수행
            }
        }
    }

    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}




extension AppDelegate: UNUserNotificationCenterDelegate {
    // foreground에서 시스템 푸시를 수신했을 때 해당 메소드가 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        completionHandler([.sound, .badge, .banner])
    }
}
