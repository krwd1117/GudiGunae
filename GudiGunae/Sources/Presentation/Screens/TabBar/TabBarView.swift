//
//  TabBarView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Domain

public struct TabBarView: View {
    @StateObject private var coordinator: TabBarCoordinator = TabBarCoordinator()
    
    
    let mapViewModel: MapViewModel = MapViewModel()
    let collectionViewModel: CollectionViewModel = CollectionViewModel()
    
    public init() {
        
    }
    
    public var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            MapView(viewModel: mapViewModel)
                .environmentObject(coordinator)
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .tag(TabBarCoordinator.Route.map)
            
            CollectionView(viewModel: collectionViewModel, mapViewModel: mapViewModel)
                .environmentObject(coordinator)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("모아보기")
                }
                .tag(TabBarCoordinator.Route.collection)
            
            SettingView(coordinator: coordinator.settingTabCoordinator)
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
                .tag(TabBarCoordinator.Route.setting)
        }
    }
}
