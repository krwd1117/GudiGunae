//
//  CollectionViewModel.swift
//  GudiGunae
//
//  Created by 김정완 on 2/26/25.
//

import Domain

import Foundation

class CollectionViewModel: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    @Published var selectedImageURL: String?
}
