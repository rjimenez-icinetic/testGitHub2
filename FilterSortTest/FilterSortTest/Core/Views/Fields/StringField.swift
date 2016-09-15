//
//  StringField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class StringField: TextInputView, Field {

    var name: String!
    var value: AnyObject?
    var required = false
    
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
        field.placeholder = label
        field.addTarget(self, action: #selector(editingDidEndAction), forControlEvents: .EditingDidEnd)
        field.addTarget(self, action: #selector(editingChangedAction), forControlEvents: .EditingChanged)
        field.autocorrectionType = .No
        
        reset()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func jsonValue() -> AnyObject? {
        return value
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        field.text = value as? String
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
    
    func editingChangedAction() {
        
        if let text = field.text where !text.trim().isEmpty {
            value = text.trim()
        } else {
            value = nil
        }
        valid()
    }
    
    func editingDidEndAction() {
        valid()
    }
}