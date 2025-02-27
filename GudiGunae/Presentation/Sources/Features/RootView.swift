import SwiftUI
import Supabase
import Data
import Domain

public struct RootView: View {
    @StateObject private var coordinator: RootCoordinator = RootCoordinator()
    
    private let supabaseClient: SupabaseClient
    
    public init() {
        let apiKeyManager = APIKeyManager()
        supabaseClient = SupabaseClient(
            supabaseURL: apiKeyManager.getSupabaseURL(),
            supabaseKey: apiKeyManager.getSupabaseKEY()
        )
    }
    
    public var body: some View {
        if coordinator.isSplashFinished {
            BottomTabBarView(supabaseClient: supabaseClient)
        } else {
            SplashView(viewModel: SplashViewModel(coordinator: coordinator))
        }
    }
}

class RootViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    func updateRestaurants(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
