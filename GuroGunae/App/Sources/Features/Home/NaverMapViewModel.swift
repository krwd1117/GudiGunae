//
//  NaverMapViewModel.swift
//  GuroGunae
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import NMapsMap

class NaverMapViewModel: ObservableObject {
    @Published var restaurants: [Restaurant]
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
}
