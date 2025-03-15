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
