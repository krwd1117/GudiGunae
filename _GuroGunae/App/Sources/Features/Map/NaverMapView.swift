//
//  NaverMapView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct NaverMapView: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @EnvironmentObject var restaurantStore: RestaurantStore
    
    @StateObject var viewModel: NaverMapViewModel
    @StateObject var mapViewModel: NaverMapWrappedViewModel = NaverMapWrappedViewModel(restaurants: [])
    
    var body: some View {
        ZStack {
            NaverMapWrappedView(viewModel: mapViewModel)
                .onReceive(restaurantStore.$restaurants) { newRestaurants in
                    mapViewModel.restaurants = newRestaurants
                }
            
            if let selectedRestaurant = mapViewModel.selectedRestaurant {
                let viewModel = RestaurantCardViewModel(selectedRestaurant: selectedRestaurant)
                RestaurantCardView(viewModel: viewModel)
                    .environmentObject(coordinator)
                    .id(selectedRestaurant.id) // 중요: ID를 설정하여 다른 레스토랑으로 변경 시 애니메이션 적용
            }
        }
    }
}
