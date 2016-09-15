//
//  OptionsField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 30/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class OptionsField: OptionsInputView, Field {
    
    var viewController: UIViewController!
    
    var name: String!
    var value: AnyObject? 
    var required = false
    
    var rules: [Rule] = []
    
    var options: [String: String]?
    
    var populate: ((Void) -> (Void))?
    
    init(name: String, label: String, required: Bool, viewController: UIViewController, options: [String: String]? = nil, value: AnyObject? = nil) {
        super.init()
        
        self.name = name
        self.value = value
        self.required = required
        self.viewController = viewController
        self.label?.text = label
        self.options = options
        if required {
            rules.append(RequiredRule())
        }
        
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
        return value
    }
    
    func clear() {
        value = nil
        reset()
    }
    
    func reset() {
        if let options = (value as? [String : String]) {
            let values = Array(options.values).sort(<)
            optionsLabel?.text = values.joinWithSeparator("\n")
        } else {
            optionsLabel?.text = nil
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
    
    func fieldTapAction() {
        
        if options != nil {
            showOptions()
        } else if let populate = populate {
            populate()
        }
    }
    
    func showOptions() {
        
        let optionsViewController = OptionsViewController()
        if let options = options {
            optionsViewController.items = options
        }
        if let options = value as? [String: String] {
            optionsViewController.optionsSelected = options
        }
        optionsViewController.delegate = self
        viewController.navigationController?.pushViewController(optionsViewController,
                                                                animated: true)
    }
}

// MARK: - <OptionsDelegate>

extension OptionsField: OptionsDelegate {
    
    func selected(options: [String : String]?) {
        
        if let options = options where options.count != 0 {
            let values = Array(options.values).sort(<)
            optionsLabel?.text = values.joinWithSeparator("\n")
            value = options
        } else {
            optionsLabel?.text = nil
            value = nil
        }
        valid()
    }
}
