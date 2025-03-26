//
//  ReportRestaurantViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI

import Core
import DI
import Domain


class ReportRestaurantViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var comment: String = ""
    
    private var reportRestaurantUseCase: ReportRestaurantUseCase
    
    init(reportRestaurantUseCase: ReportRestaurantUseCase? = nil) {
        self.reportRestaurantUseCase = reportRestaurantUseCase ?? DIContainer.shared.resolve(ReportRestaurantUseCase.self)
    }
    
    func submitButtonTapped() async {
        do {
            let report: ReportRestaurant = ReportRestaurant(
                title: title,
                comment: comment
            )
            try await reportRestaurantUseCase.execute(report: report)
        } catch {
            Logger.d(error)
        }
    }
}
