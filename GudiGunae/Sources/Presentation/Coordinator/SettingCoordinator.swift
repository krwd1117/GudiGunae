//
//  SettingCoordinator.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI
import Domain

enum SettingRoute: Hashable {
    case Report
    case Inquiry
}

class SettingCoordinator: CoordinatorProtocol {
    typealias RouteType = SettingRoute
    
    @Published var path: NavigationPath = NavigationPath()
    
    private let reportRestaurantUseCase: ReportRestaurantUseCase
    private let inquiryUseCase: InquiryUseCase
    
    init(
        reportRestaurantUseCase: ReportRestaurantUseCase,
        inquiryUseCase: InquiryUseCase
    ) {
        self.reportRestaurantUseCase = reportRestaurantUseCase
        self.inquiryUseCase = inquiryUseCase
    }
    
    @ViewBuilder
    func view(_ route: RouteType) -> some View {
        switch route {
        case .Report:
            ReportRestaurantView(
                reportRestaurantUseCase: reportRestaurantUseCase
            )
                .environmentObject(self)
        case .Inquiry:
            AppInquiryView(inquiryUseCase: inquiryUseCase)
                .environmentObject(self)
        }
    }
}
