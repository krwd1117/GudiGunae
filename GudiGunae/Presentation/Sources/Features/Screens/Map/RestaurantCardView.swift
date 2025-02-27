//
//  RestaurantCardView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import SwiftUI
import Kingfisher
import Domain

struct RestaurantCardView: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel: RestaurantCardViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    // 상단 영역: 식당 이름과 주소
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.restaurantName)
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text(viewModel.restaurantAddress)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                KFImage(viewModel.imageURL)
                    .resizable()
                    .frame(maxHeight: 200)
                
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


#Preview {
    let viewModel = RestaurantCardViewModel(
        selectedRestaurant: Restaurant(
            id: UUID(),
            name: "윤쉐프코오롱",
            address: "서울",
            latitude: 0.0,
            longitude: 0.0,
            imageURL: "https://k.kakaocdn.net/dn/n0Tiz/btsMvew04eV/MrHLdzGkZdGLbnWvBuodW1/img_xl.jpg",
            isOpen: true
        )
    )
    RestaurantCardView(viewModel: viewModel)
}
