//
//  Behavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

@objc protocol Behavior {
    
    func load()
    
    optional func appear()
    optional func disappear()
}