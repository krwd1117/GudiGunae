//
//  SettingViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/18/25.
//  Copyright © 2025 GudiGunae. All rights reserved.
//

import Foundation
import Domain

class SettingViewModel: ObservableObject {
    
    let inquiryUseCase: InquiryUseCase
    let reportRestaurantUseCase: ReportRestaurantUseCase
    
    init(inquiryUseCase: InquiryUseCase, reportRestaurantUseCase: ReportRestaurantUseCase) {
        self.inquiryUseCase = inquiryUseCase
        self.reportRestaurantUseCase = reportRestaurantUseCase
    }
    
    // 앱 버전 가져오기
    var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
}
