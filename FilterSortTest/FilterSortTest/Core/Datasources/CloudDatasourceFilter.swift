//
//  CloudDatasourceFilter.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 8/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import CoreLocation

class CloudDatasourceFilter : DatasourceFilter {

    func create(field: String, string: String) -> StringFilter? {
    
        return CloudStringFilter(field: field, string: string)
    }
    
    func create(field: String, stringList: [String]) -> StringListFilter? {
    
        return CloudStringListFilter(field: field, list: stringList)
    }
    
    func create(field: String, number: Double) -> NumberFilter? {
    
        return CloudNumberFilter(field: field, number: number)
    }
    
    func create(field: String, dateMin: NSDate?, dateMax: NSDate?) -> DateRangeFilter? {
    
        return CloudDateRangeFilter(field: field, dateMin: dateMin, dateMax: dateMax)
    }
}

extension CloudDatasourceFilter: DatasourceGeoFilter {

    func create(field: String, neCorrd: CLLocationCoordinate2D, swCoord: CLLocationCoordinate2D) -> GeoBoundingBoxFilter? {
        
        return CloudGeoBoundingBoxFilter(field: field, neCoord: neCorrd, swCoord: swCoord)
    }
    
    func create(field: String, coord: CLLocationCoordinate2D) -> GeoNearFilter? {
        
        return CloudGeoNearFilter(field: field, coord: coord)
    }
}

class CloudStringFilter: StringFilter {

    var field: String!
    var value: AnyObject?
    var string: String?
    
    init(field: String?, string: String?) {
    
        self.field = field
        self.string = string
    }
    
    func filter() -> String? {
        
        guard let f = field, s = string else {
        
            return nil
        }
        
        return "\"\(f)\":{\"$regex\":\"\(s)\",\"$options\":\"i\"}"
    }
}

class CloudStringListFilter: StringListFilter {

    var field: String!
    var value: AnyObject?
    var list: [String]?
    
    init(field: String?, list: [String]?) {
    
        self.field = field
        self.list = list
    }
    
    func filter() -> String? {
    
        guard let f = field, l = list else {
            
            return nil
        }
        
        return "\"\(f)\":{\"$in\":[\"\(l.joinWithSeparator("\",\""))\"]}"
    }
}

class CloudNumberFilter : NumberFilter {
    
    var field: String!
    var value: AnyObject?
    var number: Double?
    
    init(field: String?, number: Double?) {
    
        self.field = field
        self.number = number
    }
    
    func filter() -> String? {
        
        guard let f = field, n = number else {
            
            return nil
        }
        
        return "\"\(f)\":{\"$eq\":\(n)}"
    }
}

class CloudDateRangeFilter : DateRangeFilter {
    
    var field: String!
    var value: AnyObject?
    var dateMin: NSDate?
    var dateMax: NSDate?
    
    lazy var formatter: NSDateFormatter = {
    
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter
        
    }()
    
    init(field: String?, dateMin: NSDate?, dateMax: NSDate?) {
    
        self.field = field
        self.dateMin = dateMin
        self.dateMax = dateMax
    }
    
    func filter() -> String? {
        
        guard let f = field else {
            
            return nil
        }
        
        var paths: [String] = []
        
        if let dMin = dateMin {
        
            paths.append("\"$gte\":\"\(formatter.stringFromDate(dMin))\"")
        }
        
        if let dMax = dateMax {
        
            paths.append("\"$lte\":\"\(formatter.stringFromDate(dMax))\"")
        }
        
        guard paths.count != 0 else {
        
            return nil
        }
        
        return "\"\(f)\":{\(paths.joinWithSeparator(","))}"
    }
}

class CloudGeoBoundingBoxFilter : GeoBoundingBoxFilter {
    
    var field: String!
    var value: AnyObject?
    var neCoord: CLLocationCoordinate2D?
    var swCoord: CLLocationCoordinate2D?
    
    init(field: String?, neCoord: CLLocationCoordinate2D?, swCoord: CLLocationCoordinate2D?) {
    
        self.field = field
        self.neCoord = neCoord
        self.swCoord = swCoord
    }
    
    func filter() -> String? {
        
        guard let f = field, sw = swCoord, ne = neCoord else {
            
            return nil
        }
        
        return "\"\(f)\":{\"$geoWithin\":{\"$box\":[[\(sw.longitude),\(sw.latitude)],[\(ne.longitude),\(ne.latitude)]]}}"
    }
}

class CloudGeoNearFilter : GeoNearFilter {
    
    var field: String!
    var value: AnyObject?
    var coord: CLLocationCoordinate2D?
    
    init(field: String?, coord: CLLocationCoordinate2D?) {
        
        self.field = field
        self.coord = coord
    }
    
    func filter() -> String? {
        
        guard let f = field, c = coord else {
            
            return nil
        }
        
        return "\"\(f)\":{\"$near\":{\"$geometry\":{\"type\":\"Point\",\"coordinates\":[\(c.longitude),\(c.latitude)]}}}"
    }
}