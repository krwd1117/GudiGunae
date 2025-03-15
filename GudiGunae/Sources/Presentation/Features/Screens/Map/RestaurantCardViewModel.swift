//
//  RestaurantCardViewModel.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import Foundation
import Domain

class RestaurantCardViewModel: ObservableObject {
    @Published var selectedRestaurant: Restaurant?
    
    init(selectedRestaurant: Restaurant) {
        self.selectedRestaurant = selectedRestaurant
    }
    
    var restaurantName: String {
        selectedRestaurant?.name ?? "No Name"
    }
    
    var restaurantAddress: String {
        selectedRestaurant?.address ?? "No Address"
    }
    
    var imageURL: URL? {
        if let url = selectedRestaurant?.imageURL {
            return URL(string: url)
        } else {
            return nil
        }
    }
}
