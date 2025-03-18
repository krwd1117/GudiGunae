import SwiftUI

import Core
import Data
import Domain
import Presentation

@main
struct GuroGunaeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var isSplashInitialized: Bool = false
    @State private var isDIInitialized: Bool = false
    
    private let container = DIContainer.shared
    
    var body: some Scene {
        WindowGroup {
            if isDIInitialized && isSplashInitialized {
                TabBarView(
                    fetchRestaurantUseCase: container.resolve(FetchRestaurantUseCase.self),
                    inquiryUseCase: container.resolve(InquiryUseCase.self),
                    reportRestaurantUseCase: container.resolve(ReportRestaurantUseCase.self)
                )
            } else {
                SplashView(isInitialized: $isSplashInitialized)
                    .task {
                        await container.initialize()
                        isDIInitialized = true
                    }
            }
        }
    }
}
