//
//  NSDate+Additions.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 12/7/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

extension NSDate {
    
    static func date(string: String?) -> NSDate? {
        
        let formats = [
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ss.sss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd HH:mm:ss.S z",
            "yyyy-MM-dd HH:mm:ss z",
            "yyyy-MM-dd z",
            "yyyy-MM-dd",
            "mm/dd/yy",
            "dd/mm/yy",
            "EEEE, dd MMMM yyyy HH:mm:ss",
            "EEE, dd MMM yyyy HH:mm:ss zzz",
            "EEE, dd MMM yyyy HH:mm:ss ZZZ",
            "EEE, dd MMM yyyy HH:mm:ss Z",
            "EEE, dd MMM yyyy HH:mm:ss z"
        ]
        
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale.currentLocale()
        var date = NSDate.date(string, formats: formats, formatter: formatter);
        if date == nil {
            let localeIdentifier = "en_US"
            if NSLocale.currentLocale().localeIdentifier != localeIdentifier {
                formatter.locale = NSLocale(localeIdentifier: localeIdentifier)
                date = NSDate.date(string, formats: formats, formatter: formatter);
            }
        }
        return date
    }
    
    static func date(string: String?, formats: [String], formatter: NSDateFormatter) -> NSDate? {
    
        var date: NSDate?
        if let string = string {
            for format in formats {
                formatter.dateFormat = format
                date = formatter.dateFromString(string)
                if date != nil {
                    break
                }
            }
        }
        return date
    }
    
    func datetimeValue() -> String {
    
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .ShortStyle
        formatter.timeZone = NSTimeZone.defaultTimeZone()
        return formatter.stringFromDate(self)
    }
    
    func dateValue() -> String {
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        formatter.timeZone = NSTimeZone.defaultTimeZone()
        return formatter.stringFromDate(self)
    }
}