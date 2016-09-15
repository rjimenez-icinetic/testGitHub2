//
//  LocationField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit
import CoreLocation

class LocationField: LocationInputView, Field {
    
    var viewController: UIViewController!
    
    var name: String!
    var value: AnyObject?
    var required = false
    
    var rules: [Rule] = []
    
    var lat: Double?
    var lng: Double?
    
    init(name: String, label: String, required: Bool = false, viewController: UIViewController, value: AnyObject? = nil) {
        super.init()
        
        self.name = name
        self.value = value
        self.required = required
        self.viewController = viewController
        if required {
            rules.append(RequiredRule())
        }
        rules.append(CoordinateRule())
        self.label?.text = label
        
        latField.keyboardType = .NumbersAndPunctuation
        latField.placeholder = NSLocalizedString("Latitude", comment: "")
        latField.addTarget(self, action: #selector(editingDidEndAction), forControlEvents: .EditingDidEnd)
        latField.addTarget(self, action: #selector(editingChangedAction), forControlEvents: .EditingChanged)
        
        lngField.keyboardType = .NumbersAndPunctuation
        lngField.placeholder = NSLocalizedString("Longitude", comment: "")
        lngField.addTarget(self, action: #selector(editingDidEndAction), forControlEvents: .EditingDidEnd)
        lngField.addTarget(self, action: #selector(editingChangedAction), forControlEvents: .EditingChanged)
        
        locationButton?.addTarget(self, action: #selector(locationButtonAction), forControlEvents: .TouchUpInside)
        
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jsonValue() -> AnyObject? {
        if let geoPoint = value as? GeoPoint {
            return geoPoint.jsonValue()
        }
        return nil
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        if let geoPoint = value as? GeoPoint {
            if let coordinate = geoPoint.coordinate {
                lat = Double(coordinate.latitude)
                lng = Double(coordinate.longitude)
                latField.text = String(format: "%.8lf", coordinate.latitude)
                lngField.text = String(format: "%.8lf", coordinate.longitude)
            }
        } else {
            latField.text = nil
            lngField.text = nil
        }
        errorLabel?.text = nil
    }
    
    func valid() -> Bool {
        errorLabel?.text = nil
        var valid = true
        for rule in rules {
            if !rule.validate(value) {
                errorLabel?.text = rule.errorMessage()
                valid = false
                break
            }
        }
        return valid
    }
    
    func editingDidEndAction(textField: UITextField?) {
        assignValue(textField)
        valid()
    }
    
    func editingChangedAction(textField: UITextField?) {
        editingDidEndAction(textField)
    }
    
    func assignValue(textField: UITextField?) {
        
        if textField == latField {
            if let text = latField.text where !text.trim().isEmpty {
                lat = Double(text.trim())
            } else {
                lat = nil
            }
        } else if textField == lngField {
            if let text = lngField.text where !text.trim().isEmpty {
                lng = Double(text.trim())
            } else {
                lng = nil
            }
        }
        
        if lat == nil && lng == nil {
            value = nil
        } else {
            let geoPoint = GeoPoint()
            if let lat = lat, lng = lng {
                geoPoint.coordinate?.latitude = lat
                geoPoint.coordinate?.longitude = lng
            }
            value = geoPoint
        }
    }
    
    func locationButtonAction() {
        
        LocationManager.sharedInstance.currentLocation({ (location: CLLocation?) in
            
            self.value = nil
            if let location = location {
            
                self.lat = Double(location.coordinate.latitude)
                self.lng = Double(location.coordinate.longitude)
                let geoPoint = GeoPoint()
                geoPoint.coordinate = location.coordinate
                self.value = geoPoint
                self.latField.text = String(format: "%.8lf", location.coordinate.latitude)
                self.lngField.text = String(format: "%.8lf", location.coordinate.longitude)
            }
            self.valid()
            
        }) { (error: NSError?) in
            
            ErrorManager.show(error, rootController: self.viewController)
            
        }
    }
}