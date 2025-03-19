//
//  TabBarViewModel.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation
import Domain

class TabBarViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    private var fetchRestaurantUseCase: FetchRestaurantUseCase
    
    init(fetchRestaurantUseCase: FetchRestaurantUseCase) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
    }
    
//    @MainActor
//    func fetchRestaurant() async throws {
//        self.restaurants = try await fetchRestaurantUseCase.execute()
//    }
}
