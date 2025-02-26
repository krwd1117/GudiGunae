//
//  RestaurantDetailViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

class RestaurantDetailViewModel: ObservableObject {
    
    private var id: UUID
    
    init(id: UUID) {
        self.id = id
    }
}

