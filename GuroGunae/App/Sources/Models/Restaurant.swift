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
    let imageURL: String?
    
    let isOpen: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case latitude
        case longitude
        case imageURL = "image_url"
        case isOpen = "isOpen"
    }
}
