//
//  LocalDatasourceFilter.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 7/9/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import CoreLocation

class LocalDatasourceFilter : DatasourceFilter {
    
    func create(field: String, string: String) -> StringFilter? {
        
        return LocalStringFilter(field: field, string: string)
    }
    
    func create(field: String, stringList: [String]) -> StringListFilter? {
        
        return LocalStringListFilter(field: field, list: stringList)
    }
    
    func create(field: String, number: Double) -> NumberFilter? {
        
        return LocalNumberFilter(field: field, number: number)
    }
    
    func create(field: String, dateMin: NSDate?, dateMax: NSDate?) -> DateRangeFilter? {
        
        return LocalDateRangeFilter(field: field, dateMin: dateMin, dateMax: dateMax)
    }
}

extension LocalDatasourceFilter: DatasourceGeoFilter {
    
    func create(field: String, neCorrd: CLLocationCoordinate2D, swCoord: CLLocationCoordinate2D) -> GeoBoundingBoxFilter? {
        
        return LocalGeoBoundingBoxFilter(field: field, neCoord: neCorrd, swCoord: swCoord)
    }
    
    func create(field: String, coord: CLLocationCoordinate2D) -> GeoNearFilter? {
        
        return LocalGeoNearFilter(field: field, coord: coord)
    }
}

class LocalStringFilter: StringFilter {
    
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
        
        return "\(f) contains[cd] '\(s)'"
    }
}

class LocalStringListFilter: StringListFilter {
    
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
        
        return "\(f) IN {'\(l.joinWithSeparator("','"))'}"
    }
}

class LocalNumberFilter : NumberFilter {
    
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
        
        return "\(f) == \(n)"
    }
}

class LocalDateRangeFilter : DateRangeFilter {
    
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
        
        guard let field = field else {
            
            return nil
        }
        
        var paths: [String] = []
        
        if let dMin = dateMin {
            
            paths.append("\"\(field)\" > \"\(formatter.stringFromDate(dMin))\"")
        }
        
        if let dMax = dateMax {
            
            paths.append("\"\(field)\" < \"\(formatter.stringFromDate(dMax))\"")
        }
        
        guard paths.count != 0 else {
            
            return nil
        }
        
        return paths.joinWithSeparator(" && ")
    }
}

class LocalGeoBoundingBoxFilter : GeoBoundingBoxFilter {
    
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
        
        return nil
    }
}

class LocalGeoNearFilter : GeoNearFilter {
    
    var field: String!
    var value: AnyObject?
    var coord: CLLocationCoordinate2D?
    
    init(field: String?, coord: CLLocationCoordinate2D?) {
        
        self.field = field
        self.coord = coord
    }
    
    func filter() -> String? {
        
        return nil
    }
}