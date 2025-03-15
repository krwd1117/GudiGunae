//
//  InquiryUseCase.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import Foundation

public protocol InquiryRepository {
    func insertInquiry(inquiry: Inquiry) async throws
}

public class InquiryUseCase {
    private let repositry: InquiryRepository
    
    public init(inquiryRepository: InquiryRepository) {
        self.repositry = inquiryRepository
    }
    
    public func execute(inquiry: Inquiry) async throws {
        try await repositry.insertInquiry(inquiry: inquiry)
    }
}
