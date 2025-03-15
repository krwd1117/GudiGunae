//
//  SplashView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

struct SplashView: View {
    @StateObject var viewModel: SplashViewModel
    
    var body: some View {
        VStack {
            Text("구로디지털단지")
            Text("구내식당")
        }
        .fontWeight(.bold)
        .font(.system(size: 32))
    }
}
