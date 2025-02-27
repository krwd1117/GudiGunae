//
//  MapView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI
import Domain

struct MapView: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @EnvironmentObject var bottomTabBarViewModel: BottomTabBarViewModel
    
    @StateObject var viewModel = MapViewModel()
    
    @State var showDetailImage: Bool = false
    
    var body: some View {
        ZStack {
            NaverMapView()
                .environmentObject(viewModel)
                .onReceive(bottomTabBarViewModel.$restaurants) { newRestaurants in
                    viewModel.restaurants = newRestaurants
                }
            
            if let selectedRestaurant = viewModel.selectedRestaurant {
                let viewModel = RestaurantCardViewModel(selectedRestaurant: selectedRestaurant)
                RestaurantCardView(viewModel: viewModel)
                    .onTapGesture {
                        showDetailImage = true
                    }
                    .environmentObject(coordinator)
                    .id(selectedRestaurant.id) // 중요: ID를 설정하여 다른 레스토랑으로 변경 시 애니메이션 적용
            }
        }
        .fullScreenCover(isPresented: $showDetailImage) {
            if let imageURL = viewModel
                .selectedRestaurant?.imageURL {
                let viewModel = DetailImageViewModel(imageURL: imageURL)
                DetailImageView(viewModel: viewModel)
            }
        }
    }
}
