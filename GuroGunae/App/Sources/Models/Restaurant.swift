//
//  Restaurant.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

struct Restaurant: Identifiable, Decodable {
    let id: UUID
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let image_url: String?
}
