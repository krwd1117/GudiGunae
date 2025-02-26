//
//  CollectionView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

struct CollectionView: View {
    @EnvironmentObject var restaurantStore: RestaurantStore
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(restaurantStore.restaurants) { restaurant in
                    CollectionCellView(viewModel: CollectionCellViewModel(restaurant: restaurant))
                }
            }
            .padding()
        }
        .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    @StateObject var restaurantStore: RestaurantStore = RestaurantStore(
        restaurants: [
            Restaurant(id: .init(), name: "벽산더이룸", address: "1", latitude: 0.0, longitude: 0.0, imageURL: "https://k.kakaocdn.net/dn/cjtI7P/btsMuh23ijn/bTJDKegxGd5heuhkPqsXU1/img_xl.jpg", isOpen: true),
            Restaurant(id: .init(), name: "한신IT타워구내식당", address: "1", latitude: 0.0, longitude: 0.0, imageURL: "https://k.kakaocdn.net/dn/b0Dh9w/btsMveL4ROd/oK56uW2Y6mLWr9swY6IGOK/img_xl.jpg", isOpen: true),
            Restaurant(id: .init(), name: "미가푸드빌", address: "1", latitude: 0.0, longitude: 0.0, imageURL: "https://k.kakaocdn.net/dn/kyaWa/btsMvdGjuMo/G9sGb6TVOuUwudnuDUq6kK/img_xl.jpg", isOpen: true),
        ]
    )
    
    CollectionView()
        .environmentObject(restaurantStore)
}
