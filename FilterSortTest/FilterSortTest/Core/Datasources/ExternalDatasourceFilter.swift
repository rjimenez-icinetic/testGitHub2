//
//  ExternalDatasourceFilter.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/7/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class ExternalDatasourceFilter : DatasourceFilter {
    
    func create(field: String, string: String) -> StringFilter? {
        
        return ExternalStringFilter(field: field, string: string)
    }
    
    func create(field: String, stringList: [String]) -> StringListFilter? {
        
        return ExternalStringListFilter(field: field, list: stringList)
    }
    
    func create(field: String, number: Double) -> NumberFilter? {
        
        return ExternalNumberFilter(field: field, number: number)
    }
    
    func create(field: String, dateMin: NSDate?, dateMax: NSDate?) -> DateRangeFilter? {
        
        return ExternalDateRangeFilter(field: field, dateMin: dateMin, dateMax: dateMax)
    }
}

class ExternalStringFilter: StringFilter {
    
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

class ExternalStringListFilter: StringListFilter {
    
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
        
        return "\"\(f)\":{\"$in\":[\"\(l.joinWithSeparator(","))\"]}"
    }
}

class ExternalNumberFilter : NumberFilter {
    
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

class ExternalDateRangeFilter : DateRangeFilter {
    
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