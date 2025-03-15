//
//  RestaurantRepositoryImpl.swift
//  GudiGunae
//
//  Created by 김정완 on 2/27/25.
//

import Supabase
import Domain
import Core

public class RestaurantRepositoryImpl: RestaurantRepository {
    
    private let supabaseClient: SupabaseClient
    
    public init(supabaseClient: SupabaseClient) {
        self.supabaseClient = supabaseClient
    }
    
    public func fetchRestaurants() async throws -> [Restaurant] {
        let restaurants: [Restaurant] = try await supabaseClient
            .from("restaurants")
            .select()
            .execute()
            .value
        Logger.i(restaurants)
        return restaurants
    }
}
