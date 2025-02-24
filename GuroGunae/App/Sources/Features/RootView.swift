import SwiftUI

public struct RootView: View {
    @StateObject private var supabaseService: SupabaseService = SupabaseService()
    @StateObject private var coordinator: Coordinator = Coordinator()
    
    public var body: some View {
        if coordinator.isSplashFinished {
            NavigationStack(path: $coordinator.path) {
                coordinator.view(.home)
                    .navigationDestination(for: Route.self) { route in
                        coordinator.view(route)
                    }
            }
            .environmentObject(supabaseService)
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
