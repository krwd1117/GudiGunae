import SwiftUI

public struct RootView: View {
    @StateObject var coordinator = Coordinator()
    
    public var body: some View {
        if coordinator.isSplashFinished {
            NavigationStack(path: $coordinator.path) {
                coordinator.view(.home)
                    .navigationDestination(for: Route.self) { route in
                        coordinator.view(route)
                    }
            }
        } else {
            SplashView(viewModel: SplashViewModel(coordinator: coordinator))
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
