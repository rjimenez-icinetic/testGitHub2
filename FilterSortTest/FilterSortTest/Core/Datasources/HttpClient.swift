//
//  RestClient.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 9/4/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Alamofire
import UIKit

public class HttpClient<T : Item> {
    
    private let kMultipartData = "data"
    private let kAuthorization = "Authorization"
    
    var headers : [String : String]?
    var user : String?
    var password : String?
    
    required public init() {
        
    }
    
    func doSimpleRequest(request: Request, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), progress: ((Int64, Int64, Int64) -> Void)? = nil) {
        
        if let user = user, password = password {
            
            request.authenticate(user: user, password: password)
        }
        
        request.progress(progress)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        request.responseJSON { (response) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            if response.result.isSuccess {
                
               
                AnalyticsManager.sharedInstance?.logger?.log("Request successful " + self.getRequestInfo(request), level: LoggerLevel.LoggerLevelInfo)
                success(response.result.value)
                
            } else {
                
                AnalyticsManager.sharedInstance?.logger?.log("Request failed " + self.getRequestInfo(request), level: LoggerLevel.LoggerLevelWarn)
                
                if let statusCode = response.response?.statusCode where statusCode == 401 {
                    
                    failure(ErrorManager.auth())
                    
                } else {
                    
                    failure(response.result.error)
                }
            }
        }
    }
    
    func doRequest(request: Request, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), progress: ((Int64, Int64, Int64) -> Void)? = nil) {
        
        if let user = user, password = password {
            
            request.authenticate(user: user, password: password)
        }
        
        request.progress(progress)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        request.responseJSON { (response) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            
            AnalyticsManager.sharedInstance?.logger?.log("Request successful " + self.getRequestInfo(request), level: LoggerLevel.LoggerLevelInfo)
            
            self.processResponse(response, success: success, failure: failure)
        }
    }
    
    func processResponse(response: Response<AnyObject, NSError>, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void)) {
        
        if response.result.isSuccess {
            
            if response.result.value is NSArray {
                
                var items: [T] = []
                
                let result = response.result.value as? NSArray
                
                result?.enumerateObjectsUsingBlock({ (obj, idx, stop) in
                    
                    if obj is NSDictionary {
                        if let responseObject = T(dictionary: obj as? NSDictionary) {
                            items.append(responseObject)
                        }
                    }
                })
                
                success(items as? AnyObject)
                
            } else if response.result.value is NSDictionary {
                
                let responseObject = T(dictionary: response.result.value as? NSDictionary)
                if let _ = responseObject?.identifier {
                    success(responseObject as? AnyObject)
                } else {
                    failure(ErrorManager.mapping(nil))
                }
                
            } else {
                
                success(response.result.value)
            }
            
        } else {
            
            if let statusCode = response.response?.statusCode where statusCode == 401 {
            
                failure(ErrorManager.auth())
                
            } else {
                
                failure(response.result.error)
            }
        }
    }
    
    func auth(user: String, password: String) {
        
        self.user = user
        self.password = password
    }
    
    func request(method: Alamofire.Method, url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request {
        
        var encoding = ParameterEncoding.URL
        if method == .POST || method == .PUT {
            encoding = ParameterEncoding.JSON
        }
        let request = Alamofire.request(method, url, parameters: parameters, encoding: encoding, headers: headers)
        
        if mapping {
            doRequest(request, success: success, failure: failure, progress: progress)
        } else {
            doSimpleRequest(request, success: success, failure: failure)
        }
        
        return request
    }
    
    /*
     Only image support
     TODO: support more formats
     */
    func request(method: Alamofire.Method, url: String, parameters: [String : AnyObject]?, datas: [String : NSData], success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true) {
        
        var jsonData:NSData!
        if let parameters = parameters {
            do {
                jsonData = try NSJSONSerialization.dataWithJSONObject(parameters, options: NSJSONWritingOptions.PrettyPrinted)
            } catch let error as NSError {
                failure(error)
            }
        }
        
        if let user = user, password = password {
            if headers?[kAuthorization] == nil {
                let credentialData = "\(user):\(password)".dataUsingEncoding(NSUTF8StringEncoding)
                if let credentialData = credentialData {
                    let base64Credentials = credentialData.base64EncodedStringWithOptions([])
                    headers?[kAuthorization] = base64Credentials
                }
            }
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        Alamofire.upload(
            method,
            url,
            headers: headers,
            multipartFormData: { multipartFormData in
                
                if let jsonData = jsonData {
                    multipartFormData.appendBodyPart(data: jsonData, name: self.kMultipartData)
                }
                for (key, value) in datas {
                    multipartFormData.appendBodyPart(data: value, name: key, fileName: key, mimeType: "image/jpeg")
                }
                
            },
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                case .Success(let upload, _, _):
                    AnalyticsManager.sharedInstance?.logger?.log("Request successful " + String(["url":url, "method":method.rawValue]), level: LoggerLevel.LoggerLevelInfo)
                    upload.responseJSON { response in
                        
                        dispatch_async(dispatch_get_main_queue()) {
                            
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                        }
                        
                        self.processResponse(response, success: success, failure: failure)
                    }
                case .Failure(let encodingError):
                    AnalyticsManager.sharedInstance?.logger?.log("Request failed " + String(["url":url, "method":method.rawValue]), level: LoggerLevel.LoggerLevelWarn)
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    }
                    print(encodingError)
                    failure(ErrorManager.encoding(nil))
                }
            }
        )
    }
    
    func requestMux(method: Alamofire.Method, url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request? {
        
        var datas: [String: NSData] = [:]
        var param: [String : AnyObject] = [:]
        if let parameters = parameters {
            for (key, value) in parameters {
                if value is NSData {
                    datas[key] = value as? NSData
                    param[key] = "cid:\(key)"
                } else {
                    param[key] = value
                }
            }
        }
        
        if datas.isEmpty {
            
            return request(method, url: url, parameters: param, success: success, failure: failure, mapping: mapping, progress: progress)
            
        } else {
            
            request(method, url: url, parameters: param, datas: datas, success: success, failure: failure)
            return nil
        }
        
    }
    
    func get(url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request? {
        
        return request(.GET, url: url, parameters: parameters, success: success, failure: failure, mapping: mapping, progress: progress)
    }
    
    func post(url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request? {
        
        return requestMux(.POST, url: url, parameters: parameters, success: success, failure: failure, mapping: mapping, progress: progress)
    }
    
    func put(url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request? {
        
        return requestMux(.PUT, url: url, parameters: parameters, success: success, failure: failure, mapping: mapping, progress: progress)
    }
    
    func delete(url: String, parameters: [String : AnyObject]?, success: ((AnyObject?) -> Void), failure: ((NSError?) -> Void), mapping: Bool = true, progress: ((Int64, Int64, Int64) -> Void)? = nil) -> Request? {
        
        return request(.DELETE, url: url, parameters: parameters, success: success, failure: failure, mapping: mapping, progress: progress)
    }
	
	func getRequestInfo(request: Request) -> String{
        
        let msg:[String: String] = ["url":String(request.request?.URL), "method":String(request.request?.HTTPMethod)]
        return String(msg)
    }
    
}