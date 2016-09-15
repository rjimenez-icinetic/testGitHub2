//
//  Rules.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import CoreLocation

protocol Rule {
    
    func validate(value: AnyObject?) -> Bool
    
    func errorMessage() -> String
}

struct RequiredRule: Rule {
    
    private var message : String
    
    init(message : String = NSLocalizedString("Required", comment: "")){
        self.message = message
    }
    
    func validate(value: AnyObject?) -> Bool {
        return value != nil
    }
    
    func errorMessage() -> String {
        return message
    }
}

struct IntegerRule: Rule {
    
    private var message : String
    
    init(message : String = NSLocalizedString("Invalid integer", comment: "")) {
        self.message = message
    }
    
    func validate(value: AnyObject?) -> Bool {
        guard let value = value else {
            return true
        }
        if value is String {
            return Int(value as! String) != nil
        }
        return value is Int
    }
    
    func errorMessage() -> String {
        return message
    }
}

struct DecimalRule: Rule {
    
    private var message : String
    
    init(message : String = NSLocalizedString("Invalid decimal", comment: "")) {
        self.message = message
    }
    
    func validate(value: AnyObject?) -> Bool {
        guard let value = value else {
            return true
        }
        if value is String {
            return Double(value as! String) != nil
        }
        return value is Double
    }
    
    func errorMessage() -> String {
        return message
    }
}

struct CoordinateRule: Rule {
    
    private var message : String
    
    init(message : String = NSLocalizedString("Invalid coordinate", comment: "")) {
        self.message = message
    }
    
    func validate(value: AnyObject?) -> Bool {
        guard let value = value else {
            return true
        }
        if let geoPoint = value as? GeoPoint,
            let coordinate = geoPoint.coordinate {
            
            return CLLocationCoordinate2DIsValid(coordinate)
        }
        return true
    }
    
    func errorMessage() -> String {
        return message
    }
}


