//
//  MapView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI
import Core

import Domain

struct MapView: View {
    @EnvironmentObject private var coordinator: TabBarCoordinator
    @StateObject private var viewModel: MapViewModel
    @State var showDetailImage = false
    
    init(viewModel: MapViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.mapTabCoordinator.path) {
            ZStack {
                NaverMapView(coordinator: coordinator.mapTabCoordinator, viewModel: viewModel)
                if let selectedRestaurant = viewModel.selectedRestaurant {
                    let viewModel = RestaurantCardViewModel(selectedRestaurant: selectedRestaurant)
                    RestaurantCardView(viewModel: viewModel)
                        .environmentObject(coordinator)
                        .id(selectedRestaurant.id)
                        .onTapGesture {
                            viewModel.selectedRestaurant = selectedRestaurant
                            showDetailImage = true
                        }
                }
            }
        }
        .fullScreenCover(isPresented: $showDetailImage) {
            if let imageURL = viewModel.selectedRestaurant?.imageURL {
                let viewModel = DetailImageViewModel(imageURL: imageURL)
                DetailImageView(viewModel: viewModel)
            }
        }
    }
}
