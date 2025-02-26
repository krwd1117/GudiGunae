//
//  RestaurantCardView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import SwiftUI
import Kingfisher

struct RestaurantCardView: View {
    @EnvironmentObject var coordinator: MapCoordinator
    @StateObject var viewModel: RestaurantCardViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Spacer()
            
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
                
                // 중간 영역: 메뉴 정보 (있는 경우)
                //                if let menuInfo = viewModel.menuInfo, !menuInfo.isEmpty {
                //                    Text("메뉴")
                //                        .font(.headline)
                //                        .padding(.top, 4)
                //
                //                    Text(menuInfo)
                //                        .font(.subheadline)
                //                        .foregroundColor(.primary)
                //                }
                
                // 하단 영역: 버튼 또는 추가 정보
                HStack {
                    Button(action: {
                        if let restaurantId = viewModel.selectedRestaurant?.id {
                            coordinator.push(.restaurantDetail(id: restaurantId))
                        }
                    }) {
                        Text("상세 정보")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    // 이미지가 있는 경우 작은 썸네일로 표시
                    if let imageURL = viewModel.imageURL {
                        KFImage(imageURL)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .cornerRadius(8)
                    }
                }
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
