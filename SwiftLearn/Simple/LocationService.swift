//
//  LocationService.swift
//  SwiftLearn
//
//  Created by iimgal on 2018/12/24.
//  Copyright © 2018 jerry. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func locationDidUpdate(_ service: LocationService, location: CLLocation)
    func locationDidFail(_ service: LocationService, error: Error)
}

class LocationService: NSObject {
    var delegate:LocationServiceDelegate?
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    
    func requestLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print("Current location: \(location)")
            delegate?.locationDidUpdate(self, location: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error finding location: \(error.localizedDescription)")
        delegate?.locationDidFail(self, error: error)
    }
}
