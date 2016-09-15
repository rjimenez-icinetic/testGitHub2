//
//  DateTimeField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class DateTimeField: DateField {

    override init(name: String, label: String, required: Bool = false, value: AnyObject? = NSDate()) {
        super.init(name: name, label: label, required: required, value: value)
        
        formatter.timeStyle = .ShortStyle
        
        datePicker.datePickerMode = .DateAndTime
        
        if let value = value as? NSDate {
            field.text = formatter.stringFromDate(value)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}