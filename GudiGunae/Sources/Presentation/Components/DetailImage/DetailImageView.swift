//
//  DetailImageView.swift
//  GudiGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI
import Kingfisher

struct DetailImageView: View {
    @Environment(\.dismiss) private var dismiss
    
    @StateObject var viewModel: DetailImageViewModel
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack {
                KFImage(URL(string: viewModel.imageURL))
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .gesture(
            TapGesture()
                .onEnded { _ in
                    dismiss()
                }
        )
    }
}
