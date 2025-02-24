//
//  Restaurant.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

struct Restaurant: Identifiable, Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
}
