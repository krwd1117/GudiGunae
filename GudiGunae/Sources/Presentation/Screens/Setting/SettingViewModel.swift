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
import Domain

class SettingViewModel: ObservableObject {
    
    private var cancellabels: Set<AnyCancellable> = []
    
    @Published var isNotificationsEnabled: Bool
    
    let inquiryUseCase: InquiryUseCase
    let reportRestaurantUseCase: ReportRestaurantUseCase
    
    // 앱 버전 가져오기
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    init(inquiryUseCase: InquiryUseCase, reportRestaurantUseCase: ReportRestaurantUseCase) {
        self.inquiryUseCase = inquiryUseCase
        self.reportRestaurantUseCase = reportRestaurantUseCase
        
        self.isNotificationsEnabled = UserDefaults.standard.bool(forKey: "isNotificationsEnabled")
        
        binding()
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
