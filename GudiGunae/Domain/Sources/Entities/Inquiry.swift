//
//  Inquiry.swift
//  Presentation
//
//  Created by 김정완 on 3/5/25.
//

import Foundation

public struct Inquiry: Codable {
    let title: String
    let comment: String
    
    public init(title: String, comment: String) {
        self.title = title
        self.comment = comment
    }
}
