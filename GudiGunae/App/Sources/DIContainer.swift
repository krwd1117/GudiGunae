//
//  DIContainer.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation

import Data
import Domain

final class DIContainer: ObservableObject {
    static let shared = DIContainer()

    init() {}

    // 네트워크 서비스
    private let supabaseService = SupabaseService.shared


    // MARK: - 레스토랑 목록 가져오기
    private lazy var restaurantRepository: RestaurantRepository = {
        return RestaurantRepositoryImpl(supabaseClient: supabaseService.client)
    }()
    
    private lazy var fetchRestaurantUseCase: FetchRestaurantUseCase = {
        return FetchRestaurantUseCase(restaurantRepository: restaurantRepository)
    }()
    
    func getFetchRestaurantUseCase() -> FetchRestaurantUseCase {
        return fetchRestaurantUseCase
    }
    
    // MARK: - 레스토랑 제보하기
    private lazy var reportRestaurantRepository: ReportRestaurantRepository = {
        return ReportRestaurantImpl(supabaseClient: supabaseService.client)
    }()
    
    private lazy var reportRestaurantUseCase: ReportRestaurantUseCase = {
        return ReportRestaurantUseCase(reportRestaurantRepository: reportRestaurantRepository)
    }()
    
    func getReportRestaurantUseCase() -> ReportRestaurantUseCase {
        return reportRestaurantUseCase
    }

    // MARK: - 문의 남기기
    private lazy var inquiryRepository: InquiryRepository = {
        return InquiryImpl(supabaseClient: supabaseService.client)
    }()
    
    private lazy var inquiryUseCase: InquiryUseCase = {
        return InquiryUseCase(inquiryRepository: inquiryRepository)
    }()
    
    func getInquiryUseCase() -> InquiryUseCase {
        return inquiryUseCase
    }
}

extension DIContainer {

}
