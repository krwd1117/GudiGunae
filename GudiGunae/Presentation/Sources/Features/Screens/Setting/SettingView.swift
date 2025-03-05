//
//  SettingView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var coordinator: SettingCoordinator
    
    // 앱 버전 가져오기
    private var appVersion: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                List {
                    Button(action: {
                        coordinator.push(.Report)
                    }, label: {
                        HStack {
                            Text("식당 제보하기")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    })
                    
                    Button(action: {
                        coordinator.push(.Inquiry)
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
            .navigationDestination(for: SettingRoute.self) { route in
                coordinator.view(route)
            }
            .navigationTitle("설정")
        }
    }
}
