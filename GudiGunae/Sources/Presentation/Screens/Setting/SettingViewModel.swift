//
//  SettingViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/18/25.
//  Copyright © 2025 GudiGunae. All rights reserved.
//

import Foundation
import Combine

import Core
import DI
import Domain

class SettingViewModel: ObservableObject {
    
    private var cancellabels: Set<AnyCancellable> = []
    
    @Published var isNotificationsEnabled: Bool
    
    private let inquiryUseCase: InquiryUseCase
    private let reportRestaurantUseCase: ReportRestaurantUseCase
    
    init(inquiryUseCase: InquiryUseCase? = nil, reportRestaurantUseCase: ReportRestaurantUseCase? = nil) {
        self.inquiryUseCase = DIContainer.shared.resolve(InquiryUseCase.self)
        self.reportRestaurantUseCase = DIContainer.shared.resolve(ReportRestaurantUseCase.self)
        
        self.isNotificationsEnabled = UserDefaults.standard.bool(forKey: "isNotificationsEnabled")
        
        binding()
    }
    
    // 앱 버전 가져오기
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    private func binding() {
        $isNotificationsEnabled
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { enabled in
                Logger.d("enabled: \(enabled)")
                UserDefaults.standard.set(enabled, forKey: "isNotificationsEnabled")
            }
            .store(in: &cancellabels)
    }
}
