//
//  AnalyticsManager.swift
//  ReferenceApp
//
//  Created by Icinetic on 22/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class AnalyticsManager {
    
    static var sharedInstance : AnalyticsManager?
    
    var analytics: Analytics?
    
    var logger: Logger?
    
    static func setAnalytics(analytics: AnalyticsManager) {
        sharedInstance = analytics
    }
}
