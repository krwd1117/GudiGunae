//
//  MapCoordinator.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

import Domain

enum MapRoute: Hashable {
    case map
}

class MapCoordinator: CoordinatorProtocol {
    typealias RouteType = MapRoute
    
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func view(_ route: RouteType) -> some View {
        switch route {
        case .map:
            MapView()
                .environmentObject(self)
        }
    }
}
