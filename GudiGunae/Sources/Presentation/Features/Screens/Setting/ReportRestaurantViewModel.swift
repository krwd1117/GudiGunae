//
//  ReportRestaurantViewModel.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import SwiftUI
import Domain
import Core

class ReportRestaurantViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var comment: String = ""
    
    private var reportRestaurantUseCase: ReportRestaurantUseCase
    
    init(reportRestaurantUseCase: ReportRestaurantUseCase) {
        self.reportRestaurantUseCase = reportRestaurantUseCase
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
