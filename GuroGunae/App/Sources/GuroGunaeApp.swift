import SwiftUI
import NMapsMap

@main
struct GuroGunaeApp: App {
    
    init() {
        let apiKeyManager = APIKeyManager()
        NMFAuthManager.shared().clientId = apiKeyManager.getNaverMapClientID()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
