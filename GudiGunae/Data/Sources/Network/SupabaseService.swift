//
//  SupabaseService.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Supabase

class SupabaseService: ObservableObject {
    static let shared = SupabaseService()
    
    private let client: SupabaseClient
    
    init() {
        let apiKeyManager = APIKeyManager()
        client = SupabaseClient(
            supabaseURL: apiKeyManager.getSupabaseURL(),
            supabaseKey: apiKeyManager.getSupabaseKEY()
        )
    }
}

