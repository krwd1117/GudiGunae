//
//  HomeViewModel.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    func fetchRestaurants() async {
        do {
            let fetchedRestaurants = try await SupabaseService.shared.fetchRestaurants()
            await MainActor.run {
                restaurants = fetchedRestaurants
            }
        } catch {
            debugPrint(error)
        }
    }
}
