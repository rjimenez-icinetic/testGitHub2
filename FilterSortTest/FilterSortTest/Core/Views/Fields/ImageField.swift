//
//  ImageField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 30/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class ImageField: ImageInputView, Field {
    
    var viewController: UIViewController!
    
    var name: String!
    var value: AnyObject?
    var required = false
    
    var rules: [Rule] = []
    
    init(name: String, label: String, required: Bool, viewController: UIViewController, value: AnyObject? = nil) {
        super.init()
        self.name = name
        self.value = value
        self.required = required
        if required {
            rules.append(RequiredRule())
        }
        
        self.label?.text = label
        
        self.viewController = viewController
        
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
        imageView.image = UIImage(named: Images.noImage)
        showImage()
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
        
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .ActionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
        
            let cameraAction = UIAlertAction(title: NSLocalizedString("Take a picture", comment: ""),
                                             style: .Default,
                                             handler: { (action: UIAlertAction) in
                                                
                                                self.takePhoto(.Camera)
            })
            alertController.addAction(cameraAction)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
            
            let cameraAction = UIAlertAction(title: NSLocalizedString("Camera roll", comment: ""),
                                             style: .Default,
                                             handler: { (action: UIAlertAction) in
                                                
                                                self.takePhoto(.PhotoLibrary)
            })
            alertController.addAction(cameraAction)
        }
        
        if value != nil {
        
            let removeAction = UIAlertAction(title: NSLocalizedString("Remove", comment: ""),
                                             style: .Destructive,
                                             handler: { (action: UIAlertAction) in
                                                
                                                self.imageView.image = UIImage(named: Images.noImage)
                                                self.value = nil
            })
            alertController.addAction(removeAction)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""),
                                         style: .Cancel,
                                         handler: nil)
        
        alertController.addAction(cancelAction)
        
        viewController.presentViewController(alertController,
                                             animated: true,
                                             completion: nil)
    }
    
    func showImage() {
        
        if let image = value as? NSData {
            imageView.image = UIImage(data: image)
        } else if let resource = value as? String {
            imageView.loadImage(resource, successfully: {(success: Bool) in
                if success {
                    self.value = UIImageJPEGRepresentation(self.imageView.image!, 0.95)
                } else {
                    self.value = nil
                }
            })
        }
    }
    
    func takePhoto(type: UIImagePickerControllerSourceType) {
        
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.allowsEditing = true
        picker.delegate = self
        viewController.presentViewController(picker,
                                             animated: true,
                                             completion: nil)
    }
}

// MARK: - <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

extension ImageField: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            value = UIImageJPEGRepresentation(image, 0.95)
        }
        picker.dismissViewControllerAnimated(true) { 
            self.showImage()
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
