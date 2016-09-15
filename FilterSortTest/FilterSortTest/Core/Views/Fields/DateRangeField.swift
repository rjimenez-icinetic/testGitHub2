//
//  DateRangeField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DateRangeField: RangeInputView, Field {

    private let kDateFormat_ISO8601 = "yyyy-MM-dd'T'HH:mm:ss.sss'Z'";
    
    let formatter = NSDateFormatter()
    let jsonFormatter = NSDateFormatter()
    var datePicker: UIDatePicker!
    
    var name: String!
    var value: AnyObject? // DateRange type
    var required = false
    
    var activeField: UITextField?
    
    var rules: [Rule] = []
    
    init(name: String, label: String, required: Bool = false, value: AnyObject? = nil) {
        super.init()
        self.name = name
        self.value = value
        self.required = required
        if required {
            rules.append(RequiredRule())
        }
        self.label?.text = label
        
        jsonFormatter.dateFormat = kDateFormat_ISO8601
        
        formatter.dateStyle = .ShortStyle
        formatter.timeStyle = .NoStyle
        
        datePicker = UIDatePicker()
        datePicker.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)
        datePicker.datePickerMode = .Date
        datePicker.addTarget(self, action: #selector(valueChanedAction), forControlEvents: .ValueChanged)
        
        startField.placeholder = NSLocalizedString("Start", comment: "")
        startField.addTarget(self, action: #selector(editingDidBeginAction), forControlEvents: .EditingDidBegin)
        startField.addTarget(self, action: #selector(editingDidEndAction), forControlEvents: .EditingDidEnd)
        startField.inputView = datePicker
        
        endField.placeholder = NSLocalizedString("End", comment: "")
        endField.addTarget(self, action: #selector(editingDidBeginAction), forControlEvents: .EditingDidBegin)
        endField.addTarget(self, action: #selector(editingDidEndAction), forControlEvents: .EditingDidEnd)
        endField.inputView = datePicker
        
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jsonValue() -> AnyObject? {
        if let dateRange = value as? DateRange, startDate = dateRange.startDate, endDate = dateRange.endDate {
            return [jsonFormatter.stringFromDate(startDate), jsonFormatter.stringFromDate(endDate)]
        }
        return nil
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        if self.value is DateRange {
            let dateRange = self.value as? DateRange
            if let dateRange = dateRange {
                if let startDate = dateRange.startDate {
                    startField.text = formatter.stringFromDate(startDate)
                }
                if let endDate = dateRange.endDate {
                    endField.text = formatter.stringFromDate(endDate)
                }
            }
        } else {
            self.value = nil
            startField.text = nil
            endField.text = nil
        }
        errorLabel?.text = nil
    }
    
    func valid() -> Bool {
        errorLabel?.text = nil
        var valid = true
        for rule in rules {
            if !rule.validate(value) {
                errorLabel?.text = rule.errorMessage()
                valid = false
                break
            }
        }
        return valid
    }
    
    func editingDidBeginAction(textField: UITextField?) {
        activeField = textField
        
        let dateRange = DateRange()
        if activeField == startField {
            if let text = startField.text where text.trim().isEmpty {
                let startDate = datePicker.date
                dateRange.startDate = startDate
                activeField?.text = formatter.stringFromDate(startDate)
            }
        } else if activeField == endField {
            if let text = endField.text where text.trim().isEmpty {
                let endDate = datePicker.date
                dateRange.endDate = endDate
                activeField?.text = formatter.stringFromDate(endDate)
            }
        }
        if dateRange.startDate != nil || dateRange.endDate != nil {
            value = dateRange
        }
        valid()
    }
    
    func valueChanedAction() {
        assignValue()
    }
    
    func editingDidEndAction() {
        assignValue()
        valid()
        activeField = nil
    }
    
    func assignValue() {
        let dateRange = value as? DateRange
        if activeField == startField {
            if let text = startField.text where !text.trim().isEmpty {
                let startDate = datePicker.date
                dateRange?.startDate = startDate
                activeField?.text = formatter.stringFromDate(startDate)
            } else {
                dateRange?.startDate = nil
            }
        } else if activeField == endField {
            if let text = endField.text where !text.trim().isEmpty {
                let endDate = datePicker.date
                dateRange?.endDate = endDate
                activeField?.text = formatter.stringFromDate(endDate)
            } else {
                dateRange?.endDate = nil
            }
        }
        value = nil
        if let dateRange = dateRange {
            if dateRange.startDate != nil || dateRange.endDate != nil {
                value = dateRange
            }
        }
    }
}