//
//  FetchRestaurantUseCase.swift
//  GudiGunae
//
//  Created by 김정완 on 2/27/25.
//

import Foundation

// 프로토콜 정의
public protocol RestaurantRepository {
    func fetchRestaurants() async throws -> [Restaurant]
}

public class FetchRestaurantUseCase {
    
    private let repositry: RestaurantRepository
    
    public init(restaurantRepository: RestaurantRepository) {
        self.repositry = restaurantRepository
    }
    
    public func excute() async throws -> [Restaurant] {
        try await repositry.fetchRestaurants()
    }
    
}
