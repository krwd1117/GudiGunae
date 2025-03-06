//
//  AppDelegate.swift
//  GudiGunae
//
//  Created by 김정완 on 2/27/25.
//

import Foundation
import UserNotifications

import Core
import Data
import NMapsMap

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 앱 시작 시 로그 레벨 설정
#if DEBUG
        Logger.setLogLevel(.debug)  // 개발 환경에서는 모든 로그 표시
#else
        Logger.setLogLevel(.warning)  // 프로덕션 환경에서는 경고와 오류만 표시
#endif
        
        let apiKeyManager = APIKeyManager()
        NMFAuthManager.shared().clientId = apiKeyManager.getNaverMapClientID()
        
        return true
    }
}
