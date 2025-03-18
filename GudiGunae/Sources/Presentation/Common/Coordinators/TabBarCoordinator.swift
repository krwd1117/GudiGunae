//
//  TabBarCoordinator.swift
//  Presentation
//
//  Created by 김정완 on 3/15/25.
//  Copyright © 2025 GudiGunae. All rights reserved.
//

import SwiftUI

public final class TabBarCoordinator: Coordinator {
    enum Route: Hashable {
        case map
        case collection
        case setting
    }
    
    @Published var path: NavigationPath = NavigationPath()
    @Published var selectedTab: Route = .map
    
    var parent: (any Coordinator)?
    
    let mapTabCoordinator: MapTabCoordinator
    let collectionTabCoordinator: CollectionTabCoordinator
    let settingTabCoordinator: SettingTabCoordinator
    
    init() {
        self.mapTabCoordinator = MapTabCoordinator()
        self.collectionTabCoordinator = CollectionTabCoordinator()
        self.settingTabCoordinator = SettingTabCoordinator()
        
        // 각 코디네이터의 부모를 TabBarCoordinator로 설정
        self.mapTabCoordinator.parent = self
        self.collectionTabCoordinator.parent = self
        self.settingTabCoordinator.parent = self
    }
    
    func navigate(to route: Route) {
        switch route {
        case .map:
            selectedTab = .map
        case .collection:
            selectedTab = .collection
        case .setting:
            selectedTab = .setting
        }
    }
}



