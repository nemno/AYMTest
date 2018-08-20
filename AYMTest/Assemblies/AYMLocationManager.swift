//
//  AYMLocationManager.swift
//  AYMTest
//
//  Created by Norbert Nemes on 2018. 08. 19..
//  Copyright © 2018. Norbert Nemes. All rights reserved.
//

import UIKit
import CoreLocation

class AYMLocationManager: NSObject, CLLocationManagerDelegate {
    
    let locationManager: CLLocationManager
    private var locationUpdateCompletion: LocationUpdateCompletion?
    
    public typealias LocationUpdateCompletion = (_ location: CLLocation?, _ error:Error?) -> Void

    override init() {
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        super.init()
        
        locationManager.delegate = self
    }
    
    func getCurrentLocation(completion: @escaping LocationUpdateCompletion) {
        self.locationUpdateCompletion = completion
        self.startDeterminingCurrentLocation()
    }
    
    private func startDeterminingCurrentLocation() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: CLLocationManagerDelegate methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations[0] as CLLocation
         manager.stopUpdatingLocation()
        
        if let completion = locationUpdateCompletion {
            completion(currentLocation, nil)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        
        if let completion = locationUpdateCompletion {
            completion(nil, error)
        }
    }
}
