//
//  SettingView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var coordinator: SettingTabCoordinator
    @StateObject var viewModel: SettingViewModel = SettingViewModel()
    
    // 앱 버전 가져오기
    private var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                List {
                    Button(action: {
                        coordinator.navigate(to: .report)
                    }, label: {
                        HStack {
                            Text("식당 제보하기")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    })
                    
                    Button(action: {
                        coordinator.navigate(to: .inquiry)
                    }, label: {
                        HStack {
                            Text("앱 문의하기")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    })
                }
                .listStyle(.plain)
                
                // 앱 버전 표시 (하단 정렬)
                Text("버전 \(appVersion)")
                    .font(.footnote)
                    .padding()
            }
            .navigationDestination(for: SettingTabCoordinator.Route.self) { route in
                switch route {
                default:
                    EmptyView()
                }
            }
            .navigationTitle("설정")
        }
    }
}

class SettingViewModel: ObservableObject {
    
}
