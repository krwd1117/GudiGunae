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
import FirebaseCore
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 앱 시작 시 로그 레벨 설정
#if DEBUG
        Logger.setLogLevel(.debug)  // 개발 환경에서는 모든 로그 표시
#else
        Logger.setLogLevel(.warning)  // 프로덕션 환경에서는 경고와 오류만 표시
#endif
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // FCM 메시징 델리게이트 설정
        Messaging.messaging().delegate = self
        
        // 푸시 알림 권한 요청 및 설정
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        // 앱에 푸시 알림 등록
        application.registerForRemoteNotifications()
        
        let apiKeyManager = APIKeyManager()
        NMFAuthManager.shared().clientId = apiKeyManager.getNaverMapClientID()
        
        return true
    }
}

// MARK: - MessagingDelegate
extension AppDelegate: MessagingDelegate {
    /// FCM 등록 토큰이 업데이트 될 때 호출되는 메서드
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        // FCM 토큰이 업데이트될 때마다 서버에 전송하여 디바이스 토큰 최신화
        if let token = fcmToken {
            Logger.d("FCM 토큰 업데이트: \(token)")
        }
    }
    
    /// 앱이 APNs 토큰을 성공적으로 등록했을 때 호출되는 메서드
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // APNs 토큰을 FCM에 설정
        Messaging.messaging().apnsToken = deviceToken
    }
    
    /// APNs 토큰 등록에 실패했을 때 호출되는 메서드
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Logger.e("APNs 등록 실패: \(error.localizedDescription)")
    }
    
    /// 앱이 포그라운드 상태일 때 푸시 알림을 수신하는 메서드
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([[.banner, .badge, .sound]])
    }
    
    /// FCM 메시지를 백그라운드에서 수신하는 메서드
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        Logger.d("백그라운드에서 FCM 메시지 수신: \(userInfo)")
        completionHandler(.newData)
    }
    
    /// 사용자가 푸시 알림을 탭했을 때 호출되는 메서드
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        // 알림의 userInfo에서 필요한 데이터 추출
        let _ = response.notification.request.content.userInfo
        completionHandler()
    }
}
