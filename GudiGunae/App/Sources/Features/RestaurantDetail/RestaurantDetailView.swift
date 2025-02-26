//
//  RestaurantDetailView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct RestaurantDetailView: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @StateObject var viewModel: RestaurantDetailViewModel
    
    var body: some View {
        Button(action: {
            coordinator.pop()
        }, label: {
            Text("Detail View")
        })
    }
}

