//
//  SupabaseService.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Supabase

class SupabaseService {
    static let shared = SupabaseService()
    
    private let client: SupabaseClient
    
    init() {
        client = SupabaseClient(
          supabaseURL: URL(string: "https://hdysodqrlnrvkpxpevkx.supabase.co")!,
          supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhkeXNvZHFybG5ydmtweHBldmt4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDAxMTYwOTQsImV4cCI6MjA1NTY5MjA5NH0.c2Wod2PdWwwlk8FFoMMffYf-7ZRWpp4PlgJdC1MSPo4"
        )
    }
    
    func fetchRestaurants() async throws -> [Restaurant] {
        return try await client.from("restaurants").select().execute().value
    }
}
