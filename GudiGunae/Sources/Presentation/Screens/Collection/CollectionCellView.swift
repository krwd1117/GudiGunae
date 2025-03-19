//
//  CollectionCellView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Kingfisher

import Domain

struct CollectionCellView: View {
    @EnvironmentObject var coordinator: TabBarCoordinator
    @StateObject var mapViewModel: MapViewModel
    @StateObject var viewModel: CollectionCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.name)
                    .foregroundStyle(Color.black)
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "dot.scope")
                    .onTapGesture {
                        if let tabBarCoordinator = coordinator.collectionTabCoordinator.parent as? TabBarCoordinator {
                            tabBarCoordinator.mapTabCoordinator.mapViewModel = mapViewModel
                            tabBarCoordinator.mapTabCoordinator.navigateToMapWithRestaurant(viewModel.restaurant)
                        }
                    }
            }
            
            Divider()
            
            KFImage(viewModel.imageURL)
                .resizable()
                .frame(maxHeight: 300)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}
