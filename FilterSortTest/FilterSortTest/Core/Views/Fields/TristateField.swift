//
//  TristateField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class TristateField: TristateInputView, Field {
    
    var name: String!
    var value: AnyObject?
    var required = false
    
    init(name: String, label: String, value: AnyObject? = nil) {
        super.init()
        self.name = name
        self.value = value
        
        self.label?.text = label
        
        segmentedControl.addTarget(self,
                                   action: #selector(assignValue),
                                   forControlEvents: .ValueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(fieldTapAction))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
        
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jsonValue() -> AnyObject? {
        if let number = value as? NSNumber {
            return number.boolValue
        }
        return NSNull()
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        
        segmentedControl.selectedSegmentIndex = 1
        if let option = value as? NSNumber {
            segmentedControl.selectedSegmentIndex = option.boolValue ? 0 : 2
        } else {
            assignValue()
        }
    }
    
    func valid() -> Bool {
        return true
    }
    
    func fieldTapAction() {
        var optionSelected = segmentedControl.selectedSegmentIndex
        if optionSelected == (segmentedControl.numberOfSegments - 1) {
            optionSelected = 0
        } else {
            optionSelected += 1
        }
        segmentedControl.selectedSegmentIndex = optionSelected
        assignValue()
    }
    
    func assignValue() {
        if segmentedControl.selectedSegmentIndex == 1 {
            value = nil
        } else {
            value = NSNumber(bool: segmentedControl.selectedSegmentIndex == 0 ? true : false)
        }
    }
}