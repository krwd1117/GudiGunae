//
//  SplashView.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import SwiftUI

public struct SplashView: View {
    @StateObject var viewModel: SplashViewModel = SplashViewModel()
    @Binding var isInitialized: Bool
    
    public init(isInitialized: Binding<Bool>) {
        self._isInitialized = isInitialized
    }
    
    public var body: some View {
        VStack {
            Text("구로디지털단지")
            Text("구내식당")
        }
        .fontWeight(.bold)
        .font(.system(size: 32))
        .onChange(of: viewModel.isInitialized) { newValue in
            isInitialized = newValue
        }
    }
}
