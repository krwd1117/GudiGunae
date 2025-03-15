//
//  LocationSerivce.swift
//  GuroGunae
//
//  Created by 김정완 on 2/25/25.
//

import CoreLocation
import Combine

import Core

public class LocationService: NSObject, ObservableObject {
    public static let shared = LocationService() // 싱글톤 패턴
    
    private let locationManager = CLLocationManager()
    @Published public var authorizationStatus: CLAuthorizationStatus?
    @Published public var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        authorizationStatus = locationManager.authorizationStatus
        
        // 이미 권한이 있다면 위치 업데이트 시작
        if locationManager.authorizationStatus == .authorizedWhenInUse ||
           locationManager.authorizationStatus == .authorizedAlways {
            startUpdatingLocation()
        }
    }
    
    public func requestAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func startUpdatingLocation() {
        Logger.i("위치 업데이트 시작")
        locationManager.startUpdatingLocation()
    }
    
    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        Logger.d("위치 권한 상태 변경: \(manager.authorizationStatus.rawValue)")
        
        // 권한이 승인되면 위치 업데이트 시작
        if manager.authorizationStatus == .authorizedWhenInUse ||
           manager.authorizationStatus == .authorizedAlways {
            startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Logger.d("위치 업데이트: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        currentLocation = location
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        Logger.e("위치 업데이트 실패: \(error.localizedDescription)")
    }
}
