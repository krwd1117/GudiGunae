//
//  HomeView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: HomeViewModel
    @StateObject var mapViewModel: NaverMapViewModel = NaverMapViewModel(restaurants: [])
    
    var body: some View {
        ZStack {
            NaverMapView(viewModel: mapViewModel)
                .ignoresSafeArea()
                .task {
                    await viewModel.fetchRestaurants()
                }
                .onReceive(viewModel.$restaurants) { newRestaurants in
                    mapViewModel.restaurants = newRestaurants
                }
            
            if let selectedRestaurant = mapViewModel.selectedRestaurant {
                let viewModel = RestaurantCardViewModel(selectedRestaurant: selectedRestaurant)
                RestaurantCardView(viewModel: viewModel)
            }
        }
    }
}
