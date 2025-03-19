//
//  MapCoordinator.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

import Domain
import Core

class MapTabCoordinator: Coordinator {
    enum Route: Hashable {
        case map
    }
    
    @Published var path: NavigationPath = NavigationPath()
    
    var parent: (any Coordinator)?
    var mapViewModel: MapViewModel?
    
    init(parent: (any Coordinator)? = nil, mapViewModel: MapViewModel? = nil) {
        self.parent = parent
        self.mapViewModel = mapViewModel
    }
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateToMapWithRestaurant(_ restaurant: Restaurant) {
        Logger.d("맵으로 네비게이션 시작: \(restaurant.name)")
        
        // viewModel이 nil인지 확인
        if mapViewModel == nil {
            Logger.e("MapViewModel이 nil입니다")
        }
        
        // 선택된 레스토랑 설정 (이미 카메라 이동 포함)
        mapViewModel?.selectRestaurant(restaurant)
        
        // TabBar에서 Map 탭으로 이동
        if let tabBarCoordinator = parent as? TabBarCoordinator {
            Logger.d("탭 변경 시도")
            tabBarCoordinator.selectedTab = .map
        } else {
            Logger.e("TabBarCoordinator를 찾을 수 없습니다")
        }
    }
}
