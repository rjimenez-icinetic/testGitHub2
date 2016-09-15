//
//  Item.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 10/4/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

public protocol Item {
    
    var identifier:AnyObject? { get }
    
    init?(dictionary: NSDictionary?)
    
    func retrieve(dictionary: NSDictionary?)
}