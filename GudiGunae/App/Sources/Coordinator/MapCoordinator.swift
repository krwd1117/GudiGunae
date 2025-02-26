//
//  MapCoordinator.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

enum MapRoute: Hashable {
    case map
    case restaurantDetail(id: UUID)
}

class MapCoordinator: CoordinatorProtocol {
    typealias RouteType = MapRoute
    
    @EnvironmentObject var restaurantStore: RestaurantStore
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func view(_ route: MapRoute) -> some View {
        switch route {
        case .map:
            NaverMapView(viewModel: NaverMapViewModel())
                .environmentObject(self)
        case .restaurantDetail(let id):
            RestaurantDetailView(viewModel: RestaurantDetailViewModel(id: id))
                .environmentObject(self)
        }
    }
}

