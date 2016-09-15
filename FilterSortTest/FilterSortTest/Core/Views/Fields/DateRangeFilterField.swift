//
//  DateRangeFilterField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 2/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class DateRangeFilterField: DateRangeField {
    
    var datasource: Datasource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(datasource: Datasource, name: String, label: String, value: AnyObject?) {
        super.init(name: name, label: label, required: false, value: value)
        self.datasource = datasource
    }
}

extension DateRangeFilterField: FilterField {
    
    func filter() -> Filter? {
        
        guard let value = value else {
            return nil
        }
        let dateRange = value as! DateRange
        return datasource.datasourceFilter.create(name, dateMin: dateRange.startDate, dateMax: dateRange.endDate)
    }
}