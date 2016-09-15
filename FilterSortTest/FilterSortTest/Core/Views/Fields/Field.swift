//
//  Field.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

protocol Field {
    
    var name: String! { get }
    var value: AnyObject? { get set }
    
    func clear()
    func reset()
    func valid() -> Bool
    func jsonValue() -> AnyObject?
}

