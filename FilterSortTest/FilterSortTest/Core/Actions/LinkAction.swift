//
//  WebBrowserAction.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class LinkAction: UriAction {
    
    let prefix = "http://"
    
    override init(uri: String? = nil) {
        
        guard let uri = uri else {
            
            super.init(uri: nil)
            return
        }
        
        var url = uri.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        if url != nil && !uri.containsString("://") {
            
            url = "\(prefix)\(url!)"
        }
        
        super.init(uri: url)
    }
}