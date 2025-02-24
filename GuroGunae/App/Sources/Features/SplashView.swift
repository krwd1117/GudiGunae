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
        Text("Splash")
            .onAppear {
                viewModel.startSplashTimer()
            }
    }
}

class SplashViewModel: ObservableObject {
    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    /// 2초 후에 Splash를 종료하고 Home으로 전환합니다.
    func startSplashTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator.finishedSplash()
        }
    }
}
