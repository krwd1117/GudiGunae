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
    
    let fetchRestaurantUseCase: FetchRestaurantUseCase
    let inquiryUseCase: InquiryUseCase
    let reportRestaurantUseCase: ReportRestaurantUseCase
    
    let mapViewModel: MapViewModel
    let collectionViewModel: CollectionViewModel
    
    public init(
        fetchRestaurantUseCase: FetchRestaurantUseCase,
        inquiryUseCase: InquiryUseCase,
        reportRestaurantUseCase: ReportRestaurantUseCase
    ) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
        self.inquiryUseCase = inquiryUseCase
        self.reportRestaurantUseCase = reportRestaurantUseCase
        
        self.mapViewModel = MapViewModel(useCase: fetchRestaurantUseCase)
        self.collectionViewModel = CollectionViewModel(useCase: fetchRestaurantUseCase)
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
            
            SettingView(coordinator: coordinator.settingTabCoordinator, inquiryUseCase: inquiryUseCase, reportRestaurantUseCase: reportRestaurantUseCase)
                .tabItem {
                    Image(systemName: "gear")
                    Text("설정")
                }
                .tag(TabBarCoordinator.Route.setting)
        }
    }
}
