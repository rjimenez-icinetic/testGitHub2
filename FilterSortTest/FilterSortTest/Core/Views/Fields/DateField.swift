//
//  DateField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DateField: StringField {
    
    private let kDateFormat_ISO8601 = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'";
    
    let formatter = NSDateFormatter()
    let jsonFormatter = NSDateFormatter()
    var datePicker: UIDatePicker!
    
    override init(name: String, label: String, required: Bool = false, value: AnyObject? = nil) {
        super.init(name: name, label: label, required: required, value: value)
        
        jsonFormatter.dateFormat = kDateFormat_ISO8601
        
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        
        datePicker = UIDatePicker()
        datePicker.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: #selector(valueChanedAction), forControlEvents: .ValueChanged)
        
        field.addTarget(self, action: #selector(editingDidBeginAction), forControlEvents: .EditingDidBegin)
        
        field.inputView = datePicker
        
        if let value = value as? NSDate {
            field.text = formatter.stringFromDate(value)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func jsonValue() -> AnyObject? {
        if let date = value as? NSDate {
            return jsonFormatter.stringFromDate(date)
        }
        return nil
    }
    
    func editingDidBeginAction() {
        if value == nil {
            value = NSDate()
        }
        if let value = value as? NSDate {
            field.text = formatter.stringFromDate(value)
            valid()
        }
    }
    
    func valueChanedAction() {
        let date = datePicker.date
        value = date
        field.text = formatter.stringFromDate(date)
    }
    
    override func editingDidEndAction() {
        
        value = nil
        if let text = field.text where !text.trim().isEmpty {
            value = datePicker.date
        }
        valid()
    }
}