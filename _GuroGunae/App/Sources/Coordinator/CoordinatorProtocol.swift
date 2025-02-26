//
//  CoordinatorProtocol.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

protocol CoordinatorProtocol: ObservableObject {
    associatedtype RouteType: Hashable
    var path: NavigationPath { get set }
    
    func resetPath()
    func push(_ route: RouteType)
    func pop()
}

extension CoordinatorProtocol {
    func resetPath() {
        path = NavigationPath()
    }
    
    func push(_ route: RouteType) {
        path.append(route)
    }
    
    func pop() {
        path.removeLast()
    }
}
