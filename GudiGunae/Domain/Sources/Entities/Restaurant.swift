//
//  Restaurant.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation

public struct Restaurant: Identifiable, Decodable, Equatable, Hashable {
    public let id: UUID
    public let name: String
    public let address: String
    public let latitude: Double
    public let longitude: Double
    public let imageURL: String?
    
    public let isOpen: Bool
    
    public init(id: UUID, name: String, address: String, latitude: Double, longitude: Double, imageURL: String?, isOpen: Bool) {
        self.id = id
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.imageURL = imageURL
        self.isOpen = isOpen
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case address
        case latitude
        case longitude
        case imageURL = "image_url"
        case isOpen = "isOpen"
    }
    
    public static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.id == rhs.id
    }
}
