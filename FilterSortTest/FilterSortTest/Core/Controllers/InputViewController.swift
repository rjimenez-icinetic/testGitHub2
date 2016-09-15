//
//  InputViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class InputViewController: StackViewController {
    
    var keyboardToolbar: UIToolbar?
    var responders: [UITextField] = []
    var scrollInsets: UIEdgeInsets!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyboardToolbar = UIToolbar()
        let keyboardCloseButton = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""),
                                                  style: .Done,
                                                  target: self,
                                                  action: #selector(keyboardCloseButtonAction))
        keyboardToolbar?.items = [
            UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil),
            keyboardCloseButton
        ]
        keyboardToolbar?.sizeToFit()
        
        dispatch_async(dispatch_get_main_queue()) {
            
            self.scrollInsets = self.scrollView.contentInset
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        registerKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrieveResponders() {
    
        if self.responders.isEmpty {
            
            for view in self.contentView.subviews {
                for field in view.subviews where field is UITextField {
                    let textField = field as! UITextField
                    textField.inputAccessoryView = self.keyboardToolbar
                    self.responders.append(textField)
                }
            }
            UITextField.connectFields(self.responders)
        }
    }
    
    func keyboardCloseButtonAction() {
    
        view.endEditing(true)
    }
    
    //MARK: - Keyboard
    
    func registerKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardDidShow(_:)), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unregisterKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardDidShow(notification: NSNotification) {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            if let userInfo: NSDictionary = notification.userInfo,
                let keyboardSize = userInfo.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size {
                
                var contentInsets = self.scrollInsets
                contentInsets.bottom = keyboardSize.height
                
                self.scrollView.contentInset = contentInsets
                self.scrollView.scrollIndicatorInsets = contentInsets
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        
        dispatch_async(dispatch_get_main_queue()) {
        
            self.scrollView.contentInset = self.scrollInsets
            self.scrollView.scrollIndicatorInsets = self.scrollInsets
        }
    }
}