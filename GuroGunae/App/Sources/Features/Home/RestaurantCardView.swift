//
//  RestaurantCardView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import SwiftUI

struct RestaurantCardView: View {
    @StateObject var viewModel: RestaurantCardViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.restaurantName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(viewModel.restaurantAddress)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Button("상세 정보") {
                    // 상세 페이지로 이동하는 로직
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(16)
            .background(colorScheme == .dark ? Color(UIColor.systemGray6) : Color.white)
            .cornerRadius(16)
            .shadow(radius: 5)
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
        }
    }
}
