//
//  MapView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI
import Domain

struct MapView: View {
    @ObservedObject private var coordinator: MapTabCoordinator
    @StateObject private var viewModel: MapViewModel
    
    init(coordinator: MapTabCoordinator, useCase: FetchRestaurantUseCase) {
        self.coordinator = coordinator
        self._viewModel = StateObject(wrappedValue: MapViewModel(useCase: useCase))
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                NaverMapView(coordinator: coordinator, viewModel: viewModel)
                if let selectedRestaurant = viewModel.selectedRestaurant {
                    let viewModel = RestaurantCardViewModel(selectedRestaurant: selectedRestaurant)
                    RestaurantCardView(viewModel: viewModel)
                        .onTapGesture {
                            coordinator.showDetailImage = true
                        }
                        .environmentObject(coordinator)
                        .id(selectedRestaurant.id)
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
        .fullScreenCover(isPresented: $coordinator.showDetailImage) {
            if let imageURL = viewModel.selectedRestaurant?.imageURL {
                let viewModel = DetailImageViewModel(imageURL: imageURL)
                DetailImageView(viewModel: viewModel)
            }
        }
    }
}
