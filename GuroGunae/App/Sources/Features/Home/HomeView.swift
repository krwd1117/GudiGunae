//
//  HomeView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        
        List {
            ForEach(viewModel.restaurants, id: \.id) { restaurant in
                Button(action: {
                    coordinator.push(.detail(id: restaurant.id))
                }, label: {
                    Text(restaurant.name)
                })
            }
        }
        .task {
            await viewModel.fetchRestaurants()
        }
        
        Button(action: {
            coordinator.push(.detail(id: 0))
        }, label: {
            Text("!")
        })
    }
}
