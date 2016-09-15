//
//  LocationManager.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 28/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {

    static let sharedInstance = LocationManager()
    
    var manager: CLLocationManager!
    
    private let error = NSError(domain: NSBundle.mainBundle().bundleIdentifier!,
                        code: -401,
                        userInfo: [
                            NSLocalizedDescriptionKey: NSLocalizedString("Operation was unsuccessful.", comment: ""),
                            NSLocalizedFailureReasonErrorKey: NSLocalizedString("Location services not authorized.", comment: ""),
                            NSLocalizedRecoverySuggestionErrorKey: NSLocalizedString("his app needs you to authorize locations services to work.", comment: "")
        ])
    
    private var success: ((CLLocation?) -> (Void))?
    private var failure: ((NSError?) -> (Void))?
    
    private var updated = false
    
    override init() {
        super.init()
        
        manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
    }
    
    func currentLocation(success: ((CLLocation?) -> Void)?, failure: ((NSError?) -> Void)?) {
    
        updated = false
        self.success = success
        self.failure = failure
        
        if CLLocationManager.locationServicesEnabled() {
            
            let status = CLLocationManager.authorizationStatus()
            if status == .AuthorizedWhenInUse {
                manager.startUpdatingLocation()
            } else {
                manager.requestWhenInUseAuthorization()
            }
            
        } else {
            failure?(error)
        }
    }
}

// MARK: - <CLLocationManagerDelegate>

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        if !updated {
            updated = true
            success?(locations.last)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        if !updated {
            updated = true
            failure?(error)
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        switch status {
        case .AuthorizedWhenInUse:
            manager.startUpdatingLocation()
            break
        case .Denied:
            failure?(error)
            break
        default:
            break
        }
    }
}