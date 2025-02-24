//
//  RestaurantDetailViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

class RestaurantDetailViewModel: ObservableObject {
    
    private var id: Int
    
    init(id: Int) {
        self.id = id
    }
    
//    private func fetchRestaurantDetail() async throws -> RestaurantDetail {
//        return try await .init(id: id)
//    }
}

