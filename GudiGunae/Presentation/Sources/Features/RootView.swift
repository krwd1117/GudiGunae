import SwiftUI
import Domain

public struct RootView: View {
    @StateObject private var coordinator: RootCoordinator = RootCoordinator()
    
    let fetchRestaurantUseCase: FetchRestaurantUseCase
    
    public init(fetchRestaurantUseCase: FetchRestaurantUseCase) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
    }
    
    public var body: some View {
        if coordinator.isSplashFinished {
            BottomTabBarView(fetchRestaurantUseCase: fetchRestaurantUseCase)
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
