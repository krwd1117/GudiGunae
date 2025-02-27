//
//  SupabaseService.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import Supabase

public class SupabaseService {
    
    public static let shared = SupabaseService()
    
    public let client: SupabaseClient
    
    init() {
        let apiKeyManager = APIKeyManager()
        client = SupabaseClient(
            supabaseURL: apiKeyManager.getSupabaseURL(),
            supabaseKey: apiKeyManager.getSupabaseKEY()
        )
    }
}

