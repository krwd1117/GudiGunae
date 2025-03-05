//
//  CollectionView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var bottomTabBarViewModel: BottomTabBarViewModel
    
    @StateObject var viewModel: CollectionViewModel = CollectionViewModel()

    @State var showDetailImage: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.filteredRestaurants) { restaurant in
                    CollectionCellView(viewModel: CollectionCellViewModel(restaurant: restaurant))
                        .onTapGesture {
                            viewModel.selectedImageURL = restaurant.imageURL
                            showDetailImage = true
                        }
                }
            }
            .padding()
        }
        .onReceive(bottomTabBarViewModel.$restaurants) { newRestaurants in
            viewModel.restaurants = newRestaurants
        }
        .background(Color.gray.opacity(0.2))
        .fullScreenCover(isPresented: $showDetailImage) {
            if let imageURL = viewModel.selectedImageURL {
                let viewModel = DetailImageViewModel(imageURL: imageURL)
                DetailImageView(viewModel: viewModel)
            }
        }
        .refreshable {
            Task {
                try await bottomTabBarViewModel.fetchRestaurant()
            }
        }
    }
}
