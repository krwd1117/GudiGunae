//
//  AppCoordinator.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

enum Route: Hashable {
    case home
    case detail(id: Int)
    case setting
}

class Coordinator: ObservableObject {
    @Published var isSplashFinished: Bool = false
    @Published var path = NavigationPath()
    
    func resetPath() {
        path = NavigationPath()
    }
    
    func push(_ route: Route) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func finishedSplash() {
        withAnimation {
            isSplashFinished = true
        }
    }
    
    @ViewBuilder
    func view(_ route: Route) -> some View {
        switch route {
        case .home:
            HomeView(viewModel: HomeViewModel())
                .environmentObject(self)
        case .detail(let id):
            DetailView(viewModel: DetailViewModel(id: id))
                .environmentObject(self)
        case .setting:
            EmptyView()
                .environmentObject(self)
        }
    }
}
