//
//  RestaurantStore.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import Foundation

class RestaurantStore: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    init(restaurants: [Restaurant] = []) {
        self.restaurants = restaurants
    }
    
    func fetchRestaurants() async throws {
        let fetchedRestaurants = try await SupabaseService.shared.fetchRestaurants()
        let filteredRestaurants = fetchedRestaurants.filter { $0.isOpen }
        await MainActor.run {
            restaurants = filteredRestaurants
        }
    }
}
