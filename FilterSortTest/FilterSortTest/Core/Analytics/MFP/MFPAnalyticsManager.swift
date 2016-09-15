//
//  MFPAnalyticsManager.swift
//  ReferenceApp
//
//  Created by Icinetic on 23/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation
import IBMMobileFirstPlatformFoundation

class MFPAnalyticsManager : AnalyticsManager  {
    
    override init(){
        super.init()
        let serverURL = WLClient.sharedInstance().serverUrl
        print("Connecting to server...\n%@", serverURL)
        print("Testing Server Connection")
        WLAuthorizationManager.sharedInstance().obtainAccessTokenForScope("", withCompletionHandler:
            {(token:AccessToken!, error:NSError!) -> Void in
                if (error != nil) {
                    print("Bummer...")
                    print("Failed to connect to MobileFirst Server\n%@", serverURL)
                    print("Did not receive an access token from server: %@", error.description)
                } else {
                    print("Yay!")
                    print("Connected to MobileFirst Server\n%@", serverURL)
                    print("Received the following access token value: %@", token.value)
                }
        });
        WLAnalytics.sharedInstance().enable()
        WLAnalytics.sharedInstance().addDeviceEventListener(LIFECYCLE)
        WLAnalytics.sharedInstance().sendWithDelegate(nil);
        analytics = MFPAnalytics()
        logger = MFPLogger()
    }
}