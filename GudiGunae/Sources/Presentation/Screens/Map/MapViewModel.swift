//
//  MapViewModel.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation

import Core
import DI
import Domain

class MapViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant?
    @Published var centerLocation: (latitude: Double, longitude: Double)? // 카메라 중심 위치
    
    private let useCase: FetchRestaurantUseCase
    
    init(useCase: FetchRestaurantUseCase? = nil) {
        self.useCase = useCase ?? DIContainer.shared.resolve(FetchRestaurantUseCase.self)
    }
    
    @MainActor
    func fetchRestaurants() async {
        do {
            let restaurants = try await useCase.execute()
            self.restaurants = restaurants
        } catch {
            Logger.d(error)
        }
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        Logger.d("레스토랑 선택됨: \(restaurant.name)")
        selectedRestaurant = restaurant
        // 선택된 레스토랑의 위치로 카메라 이동
        centerLocation = (restaurant.latitude, restaurant.longitude)
        Logger.d("카메라 위치 업데이트: lat: \(restaurant.latitude), lng: \(restaurant.longitude)")
    }
    
    func clearSelection() {
        selectedRestaurant = nil
        centerLocation = nil
    }
    
    var filteredRestaurants: [Restaurant] {
        return restaurants.filter { restaurant in
            restaurant.isOpen
        }
    }
}
