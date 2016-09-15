//
//  Analytics.swift
//  ReferenceApp
//
//  Created by Icinetic on 23/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

protocol Analytics {
    func logRequest(url:String, method:String)
    func logResponse(url:String, code:String, body: AnyObject)
    func logPage(page: String)
    func logAction(action: String, entity: String, identifier: String)
    func logAction(action: String, entity: String)
    func logAction(action: String, target: String, datasourceName: String)
    func logAction(action: String, target: String)
}