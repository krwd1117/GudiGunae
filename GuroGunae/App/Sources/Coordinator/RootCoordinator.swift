//
//  RootCoordinator.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

enum RootRoute {
    case TabBar
    case Splash
}

class RootCoordinator: CoordinatorProtocol {
    typealias RouteType = RootRoute
    
    @Published var isSplashFinished: Bool = false
    @Published var path: NavigationPath = NavigationPath()
    
    func finishedSplash() {
        withAnimation {
            isSplashFinished = true
        }
    }
    
    @ViewBuilder
    func view(_ route: RootRoute) -> some View {
        switch route {
        case .TabBar:
            EmptyView()
        case .Splash:
            EmptyView()
        }
    }
}
