//
//  String+Helper.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

extension NSString {

    func isUrl() -> Bool {

        let linkDetector: NSDataDetector?
        do {
            
            linkDetector = try NSDataDetector(types: NSTextCheckingType.Link.rawValue)
            
        } catch _ {
            
            linkDetector = nil
        }
        
        guard let detector = linkDetector else {
        
            return false
        }
    
        let range = NSMakeRange(0, length)
        
        if 1 != detector.numberOfMatchesInString(self as String, options: NSMatchingOptions(rawValue: 0), range: range) {
        
            return false
        }
        
        let result = detector.firstMatchInString(self as String, options: NSMatchingOptions(rawValue: 0), range: range)
        
        guard let res = result else {
        
            return false
        }
        
        return res.resultType == .Link && NSEqualRanges(res.range, range)
    }
    
    func trim() -> String {
        
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}