//
//  DateRange.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 28/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class DateRange {
    
    var startDate: NSDate?
    var endDate: NSDate?
    
    init() {
    }
    
    init(startDate: NSDate?, endDate: NSDate?) {
        self.startDate = startDate
        self.endDate = endDate
    }
}