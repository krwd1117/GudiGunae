//
//  CollectionView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Domain

struct CollectionView: View {
    @EnvironmentObject var coordinator: TabBarCoordinator
    
    @StateObject var viewModel: CollectionViewModel
    @ObservedObject var mapViewModel: MapViewModel
    
    @State var showDetailImage: Bool = false
    
    init(viewModel: CollectionViewModel, mapViewModel: MapViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._mapViewModel = ObservedObject(wrappedValue: mapViewModel)
    }
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(viewModel.filteredRestaurants) { restaurant in
                        CollectionCellView(
                            mapViewModel: mapViewModel,
                            viewModel: CollectionCellViewModel(restaurant: restaurant)
                        )
                        .environmentObject(coordinator)
                        .onTapGesture {
                            viewModel.selectedRestaurant = restaurant
                            showDetailImage = true
                        }
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.2))
            
            .navigationTitle("모아보기")
        }
        .onAppear {
            Task {
                await viewModel.fetchRestaurants()
            }
        }
        .refreshable {
            Task {
                await viewModel.fetchRestaurants()
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
