import SwiftUI

public struct RootView: View {
    @StateObject private var supabaseService: SupabaseService = SupabaseService()
    @StateObject private var coordinator: RootCoordinator = RootCoordinator()
    @StateObject private var restaurantStore: RestaurantStore = RestaurantStore()
    
    public var body: some View {
        if coordinator.isSplashFinished {
            BottomTabBarView()
                .environmentObject(supabaseService)
                .environmentObject(restaurantStore)
        } else {
            SplashView(
                viewModel: SplashViewModel(
                    coordinator: coordinator,
                    restaurantStore: restaurantStore
                )
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
