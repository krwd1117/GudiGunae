//
//  SplashViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Combine

import Core

class SplashViewModel: ObservableObject {
    private let coordinator: RootCoordinator
    
    private var cancellables = Set<AnyCancellable>()
    
    init(coordinator: RootCoordinator) {
        self.coordinator = coordinator
        
        LocationService.shared.requestAuthorization()
        
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
