//
//  CollectionViewModel.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import Foundation
import Domain

class CollectionCellViewModel: ObservableObject {
    var restaurant: Restaurant
    
    init(restaurant: Restaurant) {
        self.restaurant = restaurant
    }
    
    var name: String {
        restaurant.name
    }
    
    var imageURL: URL? {
        if let url = restaurant.imageURL {
            return URL(string: url)
        } else {
            return nil
        }
    }
}
