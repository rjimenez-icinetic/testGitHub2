//
//  ErrorManager.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 26/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class ErrorManager {

    static func show(error: NSError?, rootController: UIViewController? = nil) {
    
        debugPrint(error)
        
        if let controller = rootController {
        
            var message = NSLocalizedString("There was a problem retrieving data", comment: "")
            
            // Auth error
            if let code = error?.code, msg = error?.localizedFailureReason where code == -6 {
                message = msg
            }
            
            let alertController = UIAlertController(title: nil,
                                                    message: message,
                                                    preferredStyle: .Alert)
            
            let closeAction = UIAlertAction(title: NSLocalizedString("Ok", comment: ""),
                                            style: .Cancel,
                                            handler: nil)
            
            alertController.addAction(closeAction)
            
            controller.presentViewController(alertController,
                                             animated: true,
                                             completion: nil)
        }
    }
    
    static func invalidUrl() -> NSError {
    
        let failureReason = "Url no valid"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -1, userInfo: [ NSLocalizedFailureReasonErrorKey : failureReason])
        return error
    }
    
    static func mapping(response: AnyObject?) -> NSError {
    
        let failureReason = "Mapper could not be serialized into response object: \(response)"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -2, userInfo: [ NSLocalizedFailureReasonErrorKey : failureReason])
        return error
    }
    
    static func encoding(response: AnyObject?) -> NSError {
        
        let failureReason = "Encoding error: \(response)"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -3, userInfo: [ NSLocalizedFailureReasonErrorKey : failureReason])
        return error
    }
    
    static func cloudantQuery() -> NSError {

        let failureReason = "Find query error"
        let description = "Cloudant query error"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -4, userInfo: [
            NSLocalizedFailureReasonErrorKey: failureReason,
            NSLocalizedDescriptionKey: description
            ])
        return error
    }
    
    static func invalidIdentifier() -> NSError {
        
        let failureReason = "Invalid identifier"
        let description = "Cloudant query error"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -5, userInfo: [
            NSLocalizedFailureReasonErrorKey: failureReason,
            NSLocalizedDescriptionKey: description
            ])
        return error
    }
    
    static func auth() -> NSError {
        
        let failureReason = "Authentication failed"
        let bundleIdentifier = NSBundle.mainBundle().bundleIdentifier
        let error = NSError(domain: bundleIdentifier ?? "", code: -6, userInfo: [ NSLocalizedFailureReasonErrorKey : failureReason])
        return error
    }
}