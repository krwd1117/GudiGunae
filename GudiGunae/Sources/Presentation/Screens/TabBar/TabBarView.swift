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
//    @StateObject var mapCoordiantor: MapCoordinator = MapCoordinator()
//    @StateObject var settingCoordinator: SettingCoordinator
//    @StateObject var viewModel: TabBarViewModel
    
    let fetchRestaurantUseCase: FetchRestaurantUseCase
//    let reportRestaurantUseCase: ReportRestaurantUseCase
//    let inquiryUseCase: InquiryUseCase
    
    public init(
        fetchRestaurantUseCase: FetchRestaurantUseCase
//        reportRestaurantUseCase: ReportRestaurantUseCase,
//        inquiryUseCase: InquiryUseCase
    ) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
//        self.reportRestaurantUseCase = reportRestaurantUseCase
//        self.inquiryUseCase = inquiryUseCase
    }
    
    public var body: some View {
        TabView {
            MapView(coordinator: coordinator.mapTabCoordinator, useCase: fetchRestaurantUseCase)
                .tabItem {
                    Image(systemName: "map")
                    Text("지도")
                }
                .tag(TabBarCoordinator.Route.map)
            
//            CollectionView(coordinator: coordinator.collectionTabCoordinator)
//                .tabItem {
//                    Image(systemName: "square.grid.2x2")
//                    Text("모아보기")
//                }
//                .tag(TabBarCoordinator.Route.collection)
            
//            SettingView(coordinator: coordinator.settingTabCoordinator)
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("설정")
//                }
//                .tag(TabBarCoordinator.Route.setting)
        }
    }
}
