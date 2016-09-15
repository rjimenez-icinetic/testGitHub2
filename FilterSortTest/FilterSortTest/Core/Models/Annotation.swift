//
//  AnnotationItem.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 25/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import MapKit

public class Annotation: MKPointAnnotation {

    var item: AnyObject?
    
    override init() {
        super.init()
    }
    
    init(item: AnyObject?, geoPoint: GeoPoint?) {
        
        super.init()
        self.item = item
        if let coord = geoPoint?.coordinate {
            coordinate = CLLocationCoordinate2DMake(coord.latitude, coord.longitude)
        }
    }
}