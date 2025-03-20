//
//  SettingView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Domain

struct SettingView: View {
    @ObservedObject var coordinator: SettingTabCoordinator
    @StateObject var viewModel: SettingViewModel
    
    init(coordinator: SettingTabCoordinator, inquiryUseCase: InquiryUseCase, reportRestaurantUseCase: ReportRestaurantUseCase) {
        self.coordinator = coordinator
        self._viewModel = StateObject(wrappedValue: SettingViewModel(
            inquiryUseCase: inquiryUseCase,
            reportRestaurantUseCase: reportRestaurantUseCase
        ))
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            VStack {
                List {
                    Toggle(isOn: $viewModel.isNotificationsEnabled) {
                        Text("앱 알림")
                    }
                    .tint(.blue)
                    
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
                Text("버전 \(viewModel.appVersion)")
                    .font(.footnote)
                    .padding()
            }
            .navigationDestination(for: SettingTabCoordinator.Route.self) { route in
                switch route {
                case .report:
                    ReportRestaurantView(reportRestaurantUseCase: viewModel.reportRestaurantUseCase)
                case .inquiry:
                    AppInquiryView(inquiryUseCase: viewModel.inquiryUseCase)
                }
            }
            .navigationTitle("설정")
        }
    }
}

