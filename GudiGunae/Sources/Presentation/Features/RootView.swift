import SwiftUI
import Domain

public struct RootView: View {
    @StateObject private var coordinator: RootCoordinator = RootCoordinator()
    
    let fetchRestaurantUseCase: FetchRestaurantUseCase
    let reportRestaurantUseCase: ReportRestaurantUseCase
    let inquiryUseCase: InquiryUseCase
    
    public init(
        fetchRestaurantUseCase: FetchRestaurantUseCase,
        reportRestaurantUseCase: ReportRestaurantUseCase,
        inquiryUseCase: InquiryUseCase
    ) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
        self.reportRestaurantUseCase = reportRestaurantUseCase
        self.inquiryUseCase = inquiryUseCase
    }
    
    public var body: some View {
        if coordinator.isSplashFinished {
            BottomTabBarView(
                fetchRestaurantUseCase: fetchRestaurantUseCase,
                reportRestaurantUseCase: reportRestaurantUseCase,
                inquiryUseCase: inquiryUseCase
            )
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
