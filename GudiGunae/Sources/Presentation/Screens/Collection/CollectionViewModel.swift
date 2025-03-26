//
//  CollectionViewModel.swift
//  GudiGunae
//
//  Created by 김정완 on 2/26/25.
//

import Foundation
import Kingfisher
import SwiftUI

import Core
import DI
import Domain


class CollectionViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var selectedRestaurant: Restaurant?
    @Published var selectedRestaurants: [Restaurant] = []
    
    @Published var activityItems: [Any] = []
    
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
            print("Error: \(error)")
        }
    }
    
    var filteredRestaurants: [Restaurant] {
        return restaurants.filter { restaurant in
            restaurant.isOpen
        }
    }
    
    @MainActor
    func createInitialShareItems() async {
        var shareItems: [Any] = []
        
        // 이미지 다운로드 및 추가
        for restaurant in selectedRestaurants {
            if let imageURLString = restaurant.imageURL,
               let imageURL = URL(string: imageURLString) {
                do {
                    let downloader = KingfisherManager.shared.downloader
                    let imageData = try await downloader.downloadImage(with: imageURL).originalData
                    let image = UIImage(data: imageData) as Any
                    shareItems.append(image)
                } catch {
                    Logger.e("이미지 다운로드 실패: \(error)")
                }
            }
        }
        
        self.activityItems = shareItems
    }
}
