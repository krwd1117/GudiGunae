//
//  MapViewModel.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Domain

import Foundation

class MapViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant?
    
    private let useCase: FetchRestaurantUseCase
    
    init(useCase: FetchRestaurantUseCase) {
        self.useCase = useCase
        Task {
            await FetchRestaurants()
        }
    }
    
    func FetchRestaurants() async {
        do {
            let restaurants = try await useCase.execute()
            self.restaurants = restaurants
        } catch {
            print("Error: \(error)")
        }
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        selectedRestaurant = restaurant
    }
    
    func clearSelection() {
        selectedRestaurant = nil
    }
    
    var filteredRestaurants: [Restaurant] {
        return restaurants.filter { restaurant in
            restaurant.isOpen
        }
    }
}
