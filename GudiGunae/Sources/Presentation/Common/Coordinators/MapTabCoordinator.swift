//
//  MapCoordinator.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

class MapTabCoordinator: Coordinator {
    enum Route: Hashable {
        case map
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
