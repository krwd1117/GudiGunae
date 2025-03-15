//
//  DIContainer.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation
import Data
import Domain

/// 의존성 주입 컨테이너의 프로토콜
/// 각 UseCase에 대한 접근 메서드를 정의합니다.
protocol DIContainerProtocol {
    func getFetchRestaurantUseCase() -> FetchRestaurantUseCase
    func getReportRestaurantUseCase() -> ReportRestaurantUseCase
    func getInquiryUseCase() -> InquiryUseCase
}

/// 의존성 주입 컨테이너 클래스
/// 앱 전체의 의존성을 관리하고 필요한 객체들을 생성하여 제공합니다.
final class DIContainer: ObservableObject, DIContainerProtocol {
    /// 싱글톤 인스턴스
    static let shared = DIContainer()
    
    /// Supabase 서비스 인스턴스
    private let supabaseService: SupabaseService
    
    /// 초기화 메서드
    /// - Parameter supabaseService: Supabase 서비스 인스턴스 (기본값: shared)
    init(supabaseService: SupabaseService = .shared) {
        self.supabaseService = supabaseService
    }
    
    // MARK: - Factory Methods
    /// 레스토랑 저장소 생성 메서드
    /// Supabase 클라이언트를 주입하여 레스토랑 저장소 구현체를 생성합니다.
    private func makeRestaurantRepository() -> RestaurantRepository {
        return RestaurantRepositoryImpl(supabaseClient: supabaseService.client)
    }
    
    /// 레스토랑 신고 저장소 생성 메서드
    /// Supabase 클라이언트를 주입하여 레스토랑 신고 저장소 구현체를 생성합니다.
    private func makeReportRestaurantRepository() -> ReportRestaurantRepository {
        return ReportRestaurantImpl(supabaseClient: supabaseService.client)
    }
    
    /// 문의사항 저장소 생성 메서드
    /// Supabase 클라이언트를 주입하여 문의사항 저장소 구현체를 생성합니다.
    private func makeInquiryRepository() -> InquiryRepository {
        return InquiryImpl(supabaseClient: supabaseService.client)
    }
    
    // MARK: - UseCases
    /// 레스토랑 조회 UseCase
    /// 레스토랑 저장소를 주입받아 레스토랑 정보를 조회하는 UseCase를 생성합니다.
    private lazy var fetchRestaurantUseCase: FetchRestaurantUseCase = {
        return FetchRestaurantUseCase(restaurantRepository: makeRestaurantRepository())
    }()
    
    /// 레스토랑 신고 UseCase
    /// 레스토랑 신고 저장소를 주입받아 레스토랑 신고를 처리하는 UseCase를 생성합니다.
    private lazy var reportRestaurantUseCase: ReportRestaurantUseCase = {
        return ReportRestaurantUseCase(reportRestaurantRepository: makeReportRestaurantRepository())
    }()
    
    /// 문의사항 UseCase
    /// 문의사항 저장소를 주입받아 문의사항을 처리하는 UseCase를 생성합니다.
    private lazy var inquiryUseCase: InquiryUseCase = {
        return InquiryUseCase(inquiryRepository: makeInquiryRepository())
    }()
    
    // MARK: - Public Methods
    /// 레스토랑 조회 UseCase 반환
    /// 싱글톤 인스턴스에서 관리되는 레스토랑 조회 UseCase를 반환합니다.
    func getFetchRestaurantUseCase() -> FetchRestaurantUseCase {
        return fetchRestaurantUseCase
    }
    
    /// 레스토랑 신고 UseCase 반환
    /// 싱글톤 인스턴스에서 관리되는 레스토랑 신고 UseCase를 반환합니다.
    func getReportRestaurantUseCase() -> ReportRestaurantUseCase {
        return reportRestaurantUseCase
    }
    
    /// 문의사항 UseCase 반환
    /// 싱글톤 인스턴스에서 관리되는 문의사항 UseCase를 반환합니다.
    func getInquiryUseCase() -> InquiryUseCase {
        return inquiryUseCase
    }
}
