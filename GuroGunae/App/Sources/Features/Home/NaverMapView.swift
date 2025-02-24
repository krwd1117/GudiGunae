//
//  NaverMap.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Foundation
import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel: NaverMapViewModel
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView: NMFNaverMapView = NMFNaverMapView()
        mapView.mapView.mapType = .basic
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // 기존 마커 제거 (중복 추가 방지)
//        uiView.mapView.overlays.forEach { overlay in
//            if let marker = overlay as? NMFMarker {
//                marker.mapView = nil
//            }
//        }
        
        // restaurants의 개수만큼 마커를 생성하여 지도에 추가
        for restaurant in viewModel.restaurants {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: restaurant.latitude, lng: restaurant.longitude)
            marker.captionText = restaurant.name
            marker.mapView = uiView.mapView
        }
    }
    
    func makeCoordinator() -> NaverMapViewCoordinator {
        NaverMapViewCoordinator(self)
    }
    
    
    class NaverMapViewCoordinator: NSObject, NMFMapViewTouchDelegate {
        var parent: NaverMapView
        
        init(_ parent: NaverMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: NMFMapView, didTap symbol: NMFSymbol) -> Bool {
            parent.coordinator.push(.detail(id: 0))
            return true
        }
    }
}

class NaverMapViewModel: ObservableObject {
    @Published var restaurants: [Restaurant]
    
    init(restaurants: [Restaurant]) {
        self.restaurants = restaurants
    }
}
