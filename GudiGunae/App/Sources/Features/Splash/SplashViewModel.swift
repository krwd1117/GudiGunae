//
//  SplashViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    private let coordinator: RootCoordinator
    private let restaurantStore: RestaurantStore
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: RootCoordinator, restaurantStore: RestaurantStore) {
        self.coordinator = coordinator
        self.restaurantStore = restaurantStore
        
        LocationService.shared.requestAuthorization()
        
        // 레스토랑 데이터 가져오기
        Task {
            do {
                try await restaurantStore.fetchRestaurants()
                Logger.i("레스토랑 데이터 로드 완료")
            } catch {
                Logger.e("레스토랑 데이터 로드 실패: \(error)")
            }
        }
        
        binding()
    }

    private func binding() {
        LocationService.shared.$authorizationStatus
            .sink { [weak self] status in
                if let status = status {
                    switch status {
                    case .authorizedWhenInUse, .authorizedAlways:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self?.coordinator.finishedSplash()
                        }
                    case .denied, .restricted:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self?.coordinator.finishedSplash()
                        }
                    case .notDetermined:
                        // 초기 상태
                        break
                    @unknown default:
                        break
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func requestLocationPermission() {
        LocationService.shared.requestAuthorization()
    }
}
