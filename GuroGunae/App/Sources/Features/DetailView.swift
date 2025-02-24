//
//  DetailView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: DetailViewModel
    
    var body: some View {
        Button(action: {
            coordinator.pop()
        }, label: {
            Text("Detail View")
        })
    }
}

class DetailViewModel: ObservableObject {
    @Published var id: Int
    
    init(id: Int) {
        self.id = id
    }
}

