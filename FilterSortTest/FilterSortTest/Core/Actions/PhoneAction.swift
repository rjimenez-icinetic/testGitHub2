//
//  PhoneAction.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class PhoneAction: UriAction {
    
    let prefix = "telprompt:"
    
    override init(uri: String? = nil) {
        
        guard let uri = uri?.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet()) else {
        
            super.init(uri: nil)
            return
        }
        
        super.init(uri: "\(prefix)\(uri)")
    }
}