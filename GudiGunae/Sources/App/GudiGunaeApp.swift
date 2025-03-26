import SwiftUI

import Core
import Data
import Domain
import Presentation
import DI

@main
struct GuroGunaeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isSplashInitialized: Bool = false
    @State private var isDIInitialized: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isDIInitialized && isSplashInitialized {
                TabBarView()
            } else {
                SplashView(isInitialized: $isSplashInitialized)
                    .task {
                        await DIContainer.shared.initialize()
                        isDIInitialized = true
                    }
            }
        }
    }
}
