//
//  BluemixAnalytics.swift
//  ReferenceApp
//
//  Created by Icinetic on 23/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation
import IBMMobileFirstPlatformFoundation

class MFPAnalytics : Analytics {

    let kPage: String = "page"
    let kUrl: String = "url"
    let kMethod: String = "http_method"
    let kRequest: String = "network_request"
    let kResponseCode: String = "response_code"
    let kResponseBody: String = "response_body"
    let kAction: String = "action"
    let kEntity: String = "entity"
    let kIdentifier: String = "identifier"
    let kDatasource: String = "datasource"
    let kTarget: String = "target"
    
    func logRequest(url:String, method:String) {
        let metadata = [kUrl: url, kMethod: method]
        WLAnalytics.sharedInstance().log(kUrl, withMetadata: metadata)
        WLAnalytics.sharedInstance().send()
    }
    
    func logResponse(url:String, code:String, body: AnyObject) {
        let metadata = [kUrl: url, kResponseCode: code, kResponseBody: body]
        WLAnalytics.sharedInstance().log(kUrl, withMetadata: metadata)
        WLAnalytics.sharedInstance().send()
    }
    
    func logPage(page: String) {
        let metadata = [kPage: page]
        WLAnalytics.sharedInstance().log(kPage, withMetadata: metadata)
        WLAnalytics.sharedInstance().send()
    }
    
    func logAction(action: String, entity: String, identifier: String) {
        let metadata = [kAction: action, kEntity: entity, kIdentifier: identifier]
        WLAnalytics.sharedInstance().log(kAction, withMetadata: metadata)
        WLAnalytics.sharedInstance().send()
    }
    
    func logAction(action: String, entity: String) {
        self.logAction(action, entity: entity, identifier: "")
    }
    
    func logAction(action: String, target: String, datasourceName: String) {
        let metadata = [kAction: action, kTarget: target, kDatasource: datasourceName]
        WLAnalytics.sharedInstance().log(kAction, withMetadata: metadata)
        WLAnalytics.sharedInstance().send()
    }
    
    func logAction(action: String, target: String) {
        self.logAction(action, target: target, datasourceName: "")
    }
}