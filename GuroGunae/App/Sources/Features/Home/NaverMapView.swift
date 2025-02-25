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
        mapView.mapView.touchDelegate = context.coordinator
        mapView.mapView.positionMode = .normal
        
        mapView.showLocationButton = true
        mapView.showCompass = true
        
        if let userLoc = LocationService.shared.currentLocation {
            let location = NMGLatLng(lat: userLoc.coordinate.latitude, lng: userLoc.coordinate.longitude)
            let cameraUpdate = NMFCameraUpdate(
                scrollTo: location,
                zoomTo: 15
            )
            mapView.mapView.moveCamera(cameraUpdate)
        } else {
            let defaultLocation = NMGLatLng(lat: 37.4833598, lng: 126.8944673)
            let cameraUpdate = NMFCameraUpdate(scrollTo: defaultLocation, zoomTo: 15)
            mapView.mapView.moveCamera(cameraUpdate)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // restaurants의 개수만큼 마커를 생성하여 지도에 추가
        for restaurant in viewModel.restaurants {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: restaurant.latitude, lng: restaurant.longitude)
            marker.captionText = restaurant.name
            marker.userInfo = ["restaurant": restaurant]
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
        
        private func mapView(_ mapView: NMFMapView, didTap marker: NMFMarker) -> Bool {
            if let restaurant = marker.userInfo["restaurant"] as? Restaurant {
                parent.coordinator.push(.restaurantDetail(id: restaurant.id))
            }
            return true
        }
    }
}
