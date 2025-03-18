//
//  CollectionTabCoordinator.swift
//  Presentation
//
//  Created by 김정완 on 3/15/25.
//  Copyright © 2025 GudiGunae. All rights reserved.
//

import SwiftUI

class CollectionTabCoordinator: Coordinator {
    enum Route: Hashable {
        case collectionView
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
