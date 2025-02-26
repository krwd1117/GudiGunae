//
//  NaverMapView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Combine

class NaverMapViewModel: ObservableObject {
    private let restaurantStore: RestaurantStore = RestaurantStore ()
    private var cancellables = Set<AnyCancellable>()
    
    @Published var restaurants: [Restaurant] = []
    
    func fetchRestaurants() {
        
    }
}
