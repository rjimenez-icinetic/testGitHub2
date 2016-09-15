//
//  Action.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 22/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

/**
 Generic protocol to handle actions
 */
protocol Action {

    /**
     Execute action
     */
    func execute()
    
    /**
     Check if the action can be executed
     */
    func canBeExecuted() -> Bool
}
