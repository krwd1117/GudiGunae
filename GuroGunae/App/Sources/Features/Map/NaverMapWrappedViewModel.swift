//
//  NaverMapViewModel.swift
//  GuroGunae
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import NMapsMap

class NaverMapWrappedViewModel: ObservableObject {
    @Published var restaurants: [Restaurant]
    @Published var selectedRestaurant: Restaurant?
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        selectedRestaurant = restaurant
    }
    
    func clearSelection() {
        selectedRestaurant = nil
    }
}
