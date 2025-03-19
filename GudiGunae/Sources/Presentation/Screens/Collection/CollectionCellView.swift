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
    @StateObject var collectionViewModel: CollectionViewModel
    @StateObject var viewModel: CollectionCellViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    if let index = collectionViewModel.selectedRestaurants.firstIndex(of: viewModel.restaurant) {
                        collectionViewModel.selectedRestaurants.remove(at: index)
                    } else {
                        collectionViewModel.selectedRestaurants.append(viewModel.restaurant)
                    }
                } label: {
                    if collectionViewModel.selectedRestaurants.contains(viewModel.restaurant){
                        Image(systemName: "checkmark.square.fill")
                            .foregroundStyle(Color.blue)
                            .font(.system(size: 20))
                            .padding(.trailing, 4)
                    } else {
                        Image(systemName: "square")
                            .foregroundStyle(Color.gray)
                            .font(.system(size: 20))
                            .padding(.trailing, 4)
                    }
                }
                
                Text(viewModel.name)
                    .foregroundStyle(Color.black)
                    .fontWeight(.bold)
                    .minimumScaleFactor(0.5) // 최소 50%까지 축소 허용
                    .lineLimit(1) // 한 줄에 맞추기
                
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
