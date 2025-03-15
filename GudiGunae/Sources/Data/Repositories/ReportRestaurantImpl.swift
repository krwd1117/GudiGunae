//
//  ReportRestaurantImpl.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import Supabase
import Domain
import Core

public class ReportRestaurantImpl: ReportRestaurantRepository {
    
    private let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func reportRestaurant(report: ReportRestaurant) async throws {
        try await supabaseClient
            .from("reports")
            .insert(report)
            .execute()
    }
}
