//
//  DIContainer.swift
//  Presentation
//
//  Created by 김정완 on 2/27/25.
//

import Foundation
import Data
import Domain

public protocol DIContainerProtocol {
    func resolve<T>(_ type: T.Type) -> T
}

/// 의존성 주입 컨테이너 클래스
/// 앱 전체의 의존성을 관리하고 필요한 객체들을 생성하여 제공합니다.
final class DIContainer: DIContainerProtocol {
    public static let shared = DIContainer()
    
    private var dependencies: [String: Any] = [:]
    private var isInitialized = false
    
    private let supabaseService: SupabaseService
    
    init(supabaseService: SupabaseService = .shared) {
        self.supabaseService = supabaseService
    }
    
    public func initialize() async {
        guard !isInitialized else { return }
        await registerDependencies()
        isInitialized = true
    }
    
    private func registerDependencies() async {
        let restaurantRepository: RestaurantRepository = RestaurantRepositoryImpl(supabaseClient: supabaseService.client)
        let fetchRestaurantUseCase = FetchRestaurantUseCase(restaurantRepository: restaurantRepository)
        register(FetchRestaurantUseCase.self, instance: fetchRestaurantUseCase)
        
        let inquiryRepository: InquiryRepository = InquiryImpl(supabaseClient: supabaseService.client)
        let inquireUseCase = InquiryUseCase(inquiryRepository: inquiryRepository)
        register(InquiryUseCase.self, instance: inquireUseCase)
        
        let reportRestaurantRepository: ReportRestaurantRepository = ReportRestaurantImpl(supabaseClient: supabaseService.client)
        let reportRestaurantUseCase = ReportRestaurantUseCase(reportRestaurantRepository: reportRestaurantRepository)
        register(ReportRestaurantUseCase.self, instance: reportRestaurantUseCase)
    }
    
    
    private func register<T>(_ type: T.Type, instance: Any) {
        dependencies[String(describing: type)] = instance
    }
    
    public func resolve<T>(_ type: T.Type) -> T {
        guard isInitialized else {
            fatalError("DIContainer is not initialized")
        }
        
        guard let instance = dependencies[String(describing: type)] as? T else {
            fatalError("No dependency found for \(type)")
        }
        return instance
    }
}
