//
//  FormViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 8/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public protocol FormDelegate {
    
    func submit(fields: [String: AnyObject]?)
}

class FormViewController: InputViewController {

    var item: Item?
    
    var crudService: CRUD?
    
    var fields: [Field] = []
    
    var formValues: [String: AnyObject] = [:]
    
    var formDelegate: FormDelegate!
    
    override required init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(resetAction))
        self.navigationItem.leftBarButtonItem = cancelButton
        
        let submitButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: #selector(submitAction))
        self.navigationItem.rightBarButtonItem = submitButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func resetAction() {
        reset()
        close()
    }
    
    func reset() {
        for var field in fields {
            field.value = formValues[field.name]
            field.reset()
        }
    }
    
    func clear() {
        for field in fields {
            field.clear()
        }
    }
    
    func submitAction() {
    
        view.endEditing(true)
        var jsonValues: [String: AnyObject] = [:]
        var valid = true
        for var field in fields {
            if field.valid() {
                formValues[field.name] = field.value
                if let jsonValue = field.jsonValue() {
                    jsonValues[field.name] = jsonValue
                }
            } else {
                formValues.removeValueForKey(field.name)
            }
            valid = valid && field.valid()
        }
        if valid {
            if let formDelegate = formDelegate {
                formDelegate.submit(jsonValues)
            }
            clear()
            close()
        }
    }

    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func retrieveFields() {
        
        if fields.isEmpty {
            for view in contentView.subviews where view is Field {
                let field = view as! Field
                fields.append(field)
                formValues[field.name] = field.value
            }
        }
        retrieveResponders()
    }
}
