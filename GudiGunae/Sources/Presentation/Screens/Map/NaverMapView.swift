//
//  NaverMap.swift
//  App
//
//  Created by 김정완 on 2/24/25.
//

import Domain
import Core

import Foundation
import SwiftUI
import NMapsMap


struct NaverMapView: UIViewRepresentable {
    @ObservedObject var coordinator: MapTabCoordinator
    @ObservedObject var viewModel: MapViewModel
    
    // 마커 관리를 위한 클래스
    private class MarkerManager {
        var markers: [NMFMarker] = []
        
        func removeAll() {
            markers.forEach { $0.mapView = nil }
            markers.removeAll()
        }
        
        func addMarker(_ marker: NMFMarker) {
            markers.append(marker)
        }
    }
    
    // 마커 매니저 인스턴스
    private let markerManager = MarkerManager()
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        let mapView: NMFNaverMapView = NMFNaverMapView()
        mapView.mapView.mapType = .basic
        mapView.mapView.touchDelegate = context.coordinator
        mapView.mapView.positionMode = .normal
        
        mapView.showLocationButton = true
        mapView.showCompass = true
        
        if let userLoc = LocationService.shared.currentLocation {
            let location = NMGLatLng(lat: userLoc.coordinate.latitude, lng: userLoc.coordinate.longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: location, zoomTo: 15)
            mapView.mapView.moveCamera(cameraUpdate)
        } else {
            let defaultLocation = NMGLatLng(lat: 37.4833598, lng: 126.8944673)
            let cameraUpdate = NMFCameraUpdate(scrollTo: defaultLocation, zoomTo: 15)
            mapView.mapView.moveCamera(cameraUpdate)
        }
        
        return mapView
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // 기존 마커들을 모두 제거
        markerManager.removeAll()
        
        // 새로운 마커 생성 및 추가
        for restaurant in viewModel.filteredRestaurants {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: restaurant.latitude, lng: restaurant.longitude)
            marker.captionText = restaurant.name
            marker.userInfo = ["restaurant": restaurant]
            
            marker.touchHandler = { [weak viewModel] (overlay: NMFOverlay) -> Bool in
                if let restaurant = marker.userInfo["restaurant"] as? Restaurant {
                    withAnimation {
                        viewModel?.selectRestaurant(restaurant)
                    }
                }
                return true
            }
            
            marker.mapView = uiView.mapView
            markerManager.addMarker(marker)
        }
        
        // 선택된 레스토랑이 있을 때 카메라 이동
        if let center = viewModel.centerLocation {
            Logger.d("카메라 이동 시도: lat: \(center.latitude), lng: \(center.longitude)")
            let location = NMGLatLng(lat: center.latitude, lng: center.longitude)
            let cameraUpdate = NMFCameraUpdate(scrollTo: location, zoomTo: 15)
            cameraUpdate.animation = .easeIn
            cameraUpdate.animationDuration = 0.5
            uiView.mapView.moveCamera(cameraUpdate)
            
            // 카메라 이동 후 centerLocation 초기화 (중복 이동 방지)
            DispatchQueue.main.async {
                viewModel.centerLocation = nil
            }
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
        
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            withAnimation {
                parent.viewModel.clearSelection()
            }
        }
    }
}
