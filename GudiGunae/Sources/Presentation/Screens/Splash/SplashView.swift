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
        ZStack {
            Color.init("SplashScreenColor")
            Image("SplashScreen")
        }
        .ignoresSafeArea()
        .onChange(of: viewModel.isInitialized) { newValue in
            isInitialized = newValue
        }
    }
}

#Preview {
    @State var isInitialized: Bool = false
    SplashView(isInitialized: $isInitialized)
}
