//
//  GeoPoint.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 25/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import CoreLocation

public class GeoPoint: Item {

    let kType = "type"
    let kCoordinates = "coordinates"
    let kTypeDefault = "Point"
    
    var type: String!
    var coordinate: CLLocationCoordinate2D?
    
    // MARK: - <Item>
    
    public var identifier: AnyObject? {
        return stringValue()
    }
    
    required public init?(dictionary: NSDictionary?) {
        
        retrieve(dictionary)
    }
    
    // MARK: - Public methods
    
    init() {
        type = kTypeDefault
        coordinate = kCLLocationCoordinate2DInvalid
    }
    
    init(lat: Double, lng: Double) {
        
        type = kTypeDefault
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
    }
    
    // MARK: - Private methods
    
    public func retrieve(dictionary: NSDictionary?) {
        
        if let dictionary = dictionary {
        
            type = dictionary[kType] as? String
            if type == nil {
                type = kTypeDefault
            }
            
            if let coord = dictionary[kCoordinates] as? [Double] {
                coordinate = CLLocationCoordinate2D(latitude: coord[1], longitude:coord[0])
            } else {
                coordinate = kCLLocationCoordinate2DInvalid
            }
        }
    }
    
    // MARK: - Public methods
    
    func jsonValue() -> [String: AnyObject]? {
    
        if let coordinate = coordinate where CLLocationCoordinate2DIsValid(coordinate){
            var json: [String: AnyObject] = [:]
            json[kType] = type
            json[kCoordinates] = [Double(coordinate.longitude), Double(coordinate.latitude)]
            return json
        }
        return nil
    }
    
    func stringValue() -> String {
        
        guard let coordinate = coordinate else {
            return ""
        }
        
        if CLLocationCoordinate2DIsValid(coordinate) {
            return String(format: "%.8lf, %.8lf", coordinate.latitude, coordinate.longitude)
        }
        return ""
    }
}

extension GeoPoint: CustomStringConvertible {

    public var description: String {
    
        return stringValue()
    }
}