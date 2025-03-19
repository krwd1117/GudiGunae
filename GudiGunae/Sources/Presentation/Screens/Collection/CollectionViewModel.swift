//
//  CollectionViewModel.swift
//  GudiGunae
//
//  Created by 김정완 on 2/26/25.
//

import Foundation

import Domain

class CollectionViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant?
    
    private let useCase: FetchRestaurantUseCase
    
    init(useCase: FetchRestaurantUseCase) {
        self.useCase = useCase
    }
    
    @MainActor
    func fetchRestaurants() async {
        do {
            let restaurants = try await useCase.execute()
            self.restaurants = restaurants
        } catch {
            print("Error: \(error)")
        }
    }
    
    var filteredRestaurants: [Restaurant] {
        return restaurants.filter { restaurant in
            restaurant.isOpen
        }
    }
}
