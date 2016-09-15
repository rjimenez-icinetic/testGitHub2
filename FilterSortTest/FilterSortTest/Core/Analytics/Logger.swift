//
//  Logger.swift
//  ReferenceApp
//
//  Created by Icinetic on 23/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

protocol Logger {
    func log(message: String, level: LoggerLevel)
}