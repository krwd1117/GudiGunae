//
//  Coordinator.swift
//  GuroGunae
//
//  Created by 김정완 on 2/26/25.
//

import SwiftUI

/// 화면 전환과 네비게이션 흐름을 관리하는 프로토콜
protocol Coordinator: ObservableObject {
    /// 각 코디네이터가 처리할 수 있는 라우트(화면 전환 경로) 타입
    associatedtype Route
    
    /// 현재 네비게이션 스택의 상태를 저장하는 프로퍼티
    var path: NavigationPath { get set }
    
    /// 상위 코디네이터에 대한 참조. 계층적 네비게이션을 위해 사용
    var parent: (any Coordinator)? { get set }
    
    /// 특정 화면으로 이동
    func navigate(to route: Route)
    
    /// 현재 화면에서 이전 화면으로 이동
    func navigateBack()
    
    /// 최상위 화면으로 이동
    func navigateToRoot()
    
    /// (부모포함) 최상위 화면으로 이동
    func popToRoot()
}

// 기본 구현을 제공
extension Coordinator {
    /// 이전 화면으로 이동
    func navigateBack() {
        guard !path.isEmpty else { return }
        path.removeLast()
    }
    
    /// 루트 화면으로 이동
    func navigateToRoot() {
        path.removeLast(path.count)
    }
    
    /// 루트 화면으로 이동
    func popToRoot() {
        if let parent = parent {
            parent.navigateToRoot()
        } else {
            navigateToRoot()
        }
    }
}
