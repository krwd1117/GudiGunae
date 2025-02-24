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
        Text("Home")
        
        Button(action: {
            coordinator.push(.detail(id: 0))
        }, label: {
            Text("!")
        })
    }
}

class HomeViewModel: ObservableObject {}
