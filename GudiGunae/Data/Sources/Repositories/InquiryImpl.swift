//
//  InquiryImpl.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import Core
import Supabase
import Domain

public class InquiryImpl: InquiryRepository {
    
    private let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func insertInquiry(inquiry: Inquiry) async throws {
        try await supabaseClient
            .from("inquiries")
            .insert(inquiry)
            .execute()
    }
}
