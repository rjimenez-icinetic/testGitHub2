//
//  BooleanField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class BooleanField: SwitchInputView, Field {

    var name: String!
    var value: AnyObject?
    var required = false
    
    init(name: String, label: String, value: AnyObject? = nil) {
        super.init()
        self.name = name
        self.value = value
        
        self.label?.text = label
        
        check.addTarget(self, action: #selector(assignValue), forControlEvents: .ValueChanged)
        
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
        return nil
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        check.on = false
        if let boolean = value as? NSNumber {
            check.on = boolean.boolValue
        } else {
            assignValue()
        }
    }
    
    func valid() -> Bool {
        return true
    }
    
    func fieldTapAction() {
        check.setOn(!check.on, animated: true)
        assignValue()
    }
    
    func assignValue() {
        value = NSNumber(bool: check.on)
    }
}