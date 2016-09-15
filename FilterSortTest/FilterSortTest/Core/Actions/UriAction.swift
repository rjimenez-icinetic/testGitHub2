//
//  UriAction.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 22/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class UriAction: Action {

    var uri: String?
    
    init(uri: String? = nil) {
    
        self.uri = uri
    }

    func execute() {
        
        if let uri = uri,
            let url = NSURL.init(string: uri) {
            
            AnalyticsManager.sharedInstance?.analytics?.logAction("open URI", target: uri)
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func canBeExecuted() -> Bool {
        
        guard let uri = uri else {
            
            return false
        }
        
        if let url = NSURL.init(string: uri) {
            return UIApplication.sharedApplication().canOpenURL(url)
        }
        return false
    }
}