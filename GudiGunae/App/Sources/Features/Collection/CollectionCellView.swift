//
//  CollectionCellView.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Kingfisher

struct CollectionCellView: View {
    @StateObject var viewModel: CollectionCellViewModel
    
    var body: some View {
        VStack {
            Text(viewModel.name)
                .fontWeight(.bold)
            
            Divider()
            
            KFImage(viewModel.imageURL)
                .resizable()
                .frame(maxHeight: 300)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct Divider: View {
    var body: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color.gray)
    }
}

#Preview {
    let viewModel = CollectionCellViewModel(
        restaurant: Restaurant(
            id: .init(),
            name: "윤쉐프 - 구로 E&C",
            address: "",
            latitude: 0,
            longitude: 0,
            imageURL: "https://k.kakaocdn.net/dn/6uJAf/btsMwB63p6z/ouduTUh0iZmkYrIOZ9dJB1/img_xl.jpg",
            isOpen: true
        )
    )
    CollectionCellView(viewModel: viewModel)
}
