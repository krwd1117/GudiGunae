//
//  RootCoordinator.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

class AppCoordinator: Coordinator {
    enum Route {
        case tapBar
        case splash
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    var parent: (any Coordinator)?
    
    init(parent: (any Coordinator)? = nil) {
        self.parent = parent
    }
    
    func navigate(to route: Route) {
        path.append(route)
    }
}
