//
//  SplashViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Combine

class SplashViewModel: ObservableObject {
    private let coordinator: Coordinator
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        
        LocationService.shared.requestLocationPermission()
        
        binding()
    }
    
    private func binding() {
        // LocationService의 권한 상태 변화를 구독
        LocationService.shared.$authorizationStatus
            .sink { [weak self] status in
                // 권한이 승인된 경우 HomeView로 이동
                if status == .authorizedAlways || status == .authorizedWhenInUse {
                    self?.coordinator.finishedSplash()
                }
            }
            .store(in: &cancellables)
    }
}
