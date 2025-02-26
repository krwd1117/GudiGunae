//
//  TabBar.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

enum BottomTabBar: Hashable {
    case map
    case collection
    case setting
}

struct BottomTabBarView: View {
    @EnvironmentObject var restaurantStore :RestaurantStore
    @StateObject var mapCoordiantor: MapCoordinator = MapCoordinator()
    
    var body: some View {
        TabView {
            // 지도 View
            NavigationStack(path: $mapCoordiantor.path) {
                mapCoordiantor.view(.map)
                    .navigationDestination(for: MapRoute.self) { route in
                        mapCoordiantor.view(route)
                    }
            }
            .environmentObject(restaurantStore)
            .tabItem {
                Image(systemName: "map")
                Text("지도")
            }
            .tag(BottomTabBar.map)
            
            CollectionView()
                .environmentObject(restaurantStore)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("모아보기")
                }
                .tag(BottomTabBar.collection)
            
            // 설정
            SettingView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
                .tag(BottomTabBar.setting)
        }
    }
}
