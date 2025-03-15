import SwiftUI

import Core
import Data
import Presentation

@main
struct GuroGunaeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var diContainer: DIContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            RootView(
                fetchRestaurantUseCase: diContainer.getFetchRestaurantUseCase(),
                reportRestaurantUseCase: diContainer.getReportRestaurantUseCase(),
                inquiryUseCase: diContainer.getInquiryUseCase()
            )
        }
    }
}
