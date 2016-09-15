//
//  BluemixLogger.swift
//  ReferenceApp
//
//  Created by Icinetic on 23/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation
import IBMMobileFirstPlatformFoundation

class MFPLogger : Logger {
    
    let logger:OCLogger
    
    init() {
        logger =  OCLogger.getInstanceWithPackage("main")
    }
    
    func log(message: String, level: LoggerLevel){
        switch level {
            case .LoggerLevelLog: logger.logWithLevel(OCLogger_LOG, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelAnalytics: logger.logWithLevel(OCLogger_ANALYTICS, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelTrace: logger.logWithLevel(OCLogger_TRACE, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelInfo: logger.logWithLevel(OCLogger_INFO, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelWarn: logger.logWithLevel(OCLogger_WARN, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelDebug: logger.logWithLevel(OCLogger_DEBUG, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelError: logger.logWithLevel(OCLogger_ERROR, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
            case .LoggerLevelFatal: logger.logWithLevel(OCLogger_FATAL, message: message, args: CVaListPointer(_fromUnsafeMutablePointer: nil), userInfo: nil)
        }
        OCLogger.send()
    }
}