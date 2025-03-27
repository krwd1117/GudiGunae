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
        // 지도에 마커 그림
        drawMakers(uiView: uiView)
        
        // 선택된 레스토랑이 있을 때 카메라 이동
        moveCameraToSelectedRestaurant(uiView: uiView)
    }
    
    /// 지도에 마커를 그림
    private func drawMakers(uiView: NMFNaverMapView) {
        // 새로운 마커 생성 및 추가
        for restaurant in viewModel.filteredRestaurants {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: restaurant.latitude, lng: restaurant.longitude)
            marker.captionText = restaurant.name
            marker.userInfo["restaurant"] = restaurant
            
            // 무채색 아이콘(검정색)으로 설정
            // 이렇게 하지않고 tintColor만 수정하면 색상이 겹쳐보임
            marker.iconImage = NMF_MARKER_IMAGE_BLACK
            
            // 마커를 눌렀을 때
            marker.touchHandler = { [weak viewModel] (overlay: NMFOverlay) -> Bool in
                if let restaurant = marker.userInfo["restaurant"] as? Restaurant {
                    withAnimation {
                        viewModel?.selectRestaurant(restaurant)
                    }
                }
                return true
            }
            
            if let selectedRestaurant = viewModel.selectedRestaurant,
               let currentRestaurant = marker.userInfo["restaurant"] as? Restaurant,
               currentRestaurant == selectedRestaurant {
                marker.iconImage = NMF_MARKER_IMAGE_RED
            } else {
                marker.iconImage = NMF_MARKER_IMAGE_GREEN
            }
            
            marker.mapView = uiView.mapView
        }
    }
    
    /// 선택한 식당의 위치로 카메라를 이동
    private func moveCameraToSelectedRestaurant(uiView: NMFNaverMapView) {
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
