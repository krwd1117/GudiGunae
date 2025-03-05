//
//  TabBar.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

import Domain

enum BottomTabBar: Hashable {
    case map
    case collection
    case setting
}

struct BottomTabBarView: View {
    @StateObject var mapCoordiantor: MapCoordinator = MapCoordinator()
    @StateObject var settingCoordinator: SettingCoordinator
    @StateObject var bottomTabBarViewModel: BottomTabBarViewModel
    
    init(
        fetchRestaurantUseCase: FetchRestaurantUseCase,
        reportRestaurantUseCase: ReportRestaurantUseCase,
        inquiryUseCase: InquiryUseCase
    ) {
        _settingCoordinator = StateObject(
            wrappedValue: SettingCoordinator(
                reportRestaurantUseCase: reportRestaurantUseCase,
                inquiryUseCase: inquiryUseCase
            )
        )
        _bottomTabBarViewModel = StateObject(wrappedValue: BottomTabBarViewModel(fetchRestaurantUseCase: fetchRestaurantUseCase))
    }
    
    var body: some View {
        TabView {
            // 지도 View
            NavigationStack(path: $mapCoordiantor.path) {
                mapCoordiantor.view(.map)
                    .navigationDestination(for: MapRoute.self) { route in
                        mapCoordiantor.view(route)
                    }
            }
            .environmentObject(bottomTabBarViewModel)
            .tabItem {
                Image(systemName: "map")
                Text("지도")
            }
            .tag(BottomTabBar.map)
            
            // 식당 CollectionView
            CollectionView()
                .environmentObject(bottomTabBarViewModel)
                .tabItem {
                    Image(systemName: "square.grid.2x2")
                    Text("모아보기")
                }
                .tag(BottomTabBar.collection)
            
            // 설정
            SettingView()
                .environmentObject(settingCoordinator)
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
                .tag(BottomTabBar.setting)
        }
        .onAppear {
            Task {
                try await bottomTabBarViewModel.fetchRestaurant()
            }
        }
    }
}

