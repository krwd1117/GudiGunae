//
//  SettingCoordinator.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI
import Domain

class SettingTabCoordinator: Coordinator {
    enum Route: Hashable {
        case report
        case inquiry
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
