//
//  DIContainer.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation

import Data
import Domain

final class DIContainer {
    static let shared = DIContainer()

    private init() {}

    // 네트워크 서비스
    private let supabaseService = SupabaseService.shared

    // Repository
    private lazy var restaurantRepository: RestaurantRepository = {
        return RestaurantRepositoryImpl(supabaseClient: supabaseService.client)
    }()

    // UseCase
    private lazy var fetchRestaurantUseCase: FetchRestaurantUseCase = {
        return FetchRestaurantUseCase(restaurantRepository: restaurantRepository)
    }()

    // UseCase를 제공하는 함수
    func getFetchRestaurantUseCase() -> FetchRestaurantUseCase {
        return fetchRestaurantUseCase
    }
}
