//
//  SplashViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Combine

import Core

public class SplashViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var isInitialized: Bool = false
    
    public init() {
        requestLocationPermission()
        binding()
    }
    
    private func binding() {
        LocationService.shared.$authorizationStatus
            .sink { [weak self] status in
                if let status = status {
                    switch status {
                    case .authorizedWhenInUse, .authorizedAlways:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self?.isInitialized = true
                        }
                    case .denied, .restricted:
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self?.isInitialized = true
                        }
                    case .notDetermined:
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
