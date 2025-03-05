//
//  ReportRestaurantUseCase.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import Foundation

// 프로토콜 정의
public protocol ReportRestaurantRepository {
    func reportRestaurant(report: ReportRestaurant) async throws
}

public class ReportRestaurantUseCase {
    
    private let repositry: ReportRestaurantRepository
    
    public init(reportRestaurantRepository: ReportRestaurantRepository) {
        self.repositry = reportRestaurantRepository
    }
    
    public func execute(report: ReportRestaurant) async throws {
        try await repositry.reportRestaurant(report: report)
    }
}
