import SwiftUI
import NMapsMap

@main
struct GuroGunaeApp: App {
    
    init() {
        // 앱 시작 시 로그 레벨 설정
        #if DEBUG
        Logger.setLogLevel(.info)  // 개발 환경에서는 모든 로그 표시
        #else
        Logger.setLogLevel(.warning)  // 프로덕션 환경에서는 경고와 오류만 표시
        #endif
        
        Logger.i("앱 시작됨")
        
        let apiKeyManager = APIKeyManager()
        NMFAuthManager.shared().clientId = apiKeyManager.getNaverMapClientID()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
