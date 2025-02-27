//
//  DetailViewModel.swift
//  GudiGunae
//
//  Created by 김정완 on 2/26/25.
//

import Foundation

class DetailImageViewModel: ObservableObject {
    @Published var imageURL: String
    
    init(imageURL: String) {
        self.imageURL = imageURL
    }
}
