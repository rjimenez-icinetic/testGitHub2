//
//  CloudDatasource.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 21/3/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class CloudDatasource <T:Item> {

    let kCloudDatasourceApikey       = "apikey"
    let kCloudDatasourceSort         = "sort"
    let kCloudDatasourceSkip         = "skip"
    let kCloudDatasourceLimit        = "limit"
    let kCloudDatasourceConditions   = "conditions"
    let kCloudDatasourceDistinct     = "distinct"
    
    var baseUrl: String?
    var resource: String?
    var apikey: String?
    var searchableFields: [String]?
    
    var restClient: HttpClient<T>
    
    var progress:((Int64, Int64, Int64) -> Void)?
    
    let filter = CloudDatasourceFilter()
    
    private var baseUrlImage: String!
    
    init(baseUrl: String, resource: String, apikey: String, searchableFields : [String]) {
    
        self.baseUrl = baseUrl
        self.resource = resource
        self.apikey = apikey
        self.searchableFields = searchableFields
        restClient = HttpClient<T>()
        restClient.headers = [kCloudDatasourceApikey : apikey]
        
        if let range = resource.rangeOfString("/r/") {
            let resourcePath = resource.substringToIndex(range.startIndex)
            baseUrlImage = "\(baseUrl)\(resourcePath)"
        } else {
        
            baseUrlImage = "\(baseUrl)\(resource)"
        }
    }
    
    func requestParameters(options: DatasourceOptions?) -> [String : AnyObject] {
    
        var params: [String: AnyObject] = [:]
        
        guard let datasourceOptions = options else {
            
            return params
        }
        
        // Sort options
        if datasourceOptions.sortOptions.count != 0 {
            
            let sortOptions = datasourceOptions.sortOptions[0]
            if var sortField = sortOptions.field,
                let sortAscending = sortOptions.ascending {
                
                if !sortAscending {
                    
                    sortField.insert("-", atIndex: sortField.startIndex.advancedBy(0))
                }
                params[kCloudDatasourceSort] = sortField
            }
        }
        
        var conditions: [String] = []
        
        // Search text. This should be a $text index in Rest's mongodb
        if let searchText = datasourceOptions.searchText,
            let searchableFields = searchableFields {
            
            var searches: [String] = []
            for field in searchableFields {
                
                let q = "{\"\(field)\":{\"$regex\":\"\(searchText)\",\"$options\":\"i\"}}"
                searches.append(q)
            }
            conditions.append("\"$or\":[\(searches.joinWithSeparator(","))]")
        }
        
        // Runtime filters
        if datasourceOptions.filters.count != 0 {
            
            for filter in datasourceOptions.filters {
                
                if let filterQuery = filter.filter() {
                    
                    conditions.append(filterQuery)
                }
            }
        }
        
        // Design filters
        if datasourceOptions.designFilters.count != 0 {
            
            var filters: [String] = []
            for filter in datasourceOptions.designFilters {
                
                if let filterQuery = filter.filter() {
                    
                    filters.append("{\(filterQuery)}")
                }
            }
            if filters.count != 0 {
                
                conditions.append("\"$and\":[\(filters.joinWithSeparator(","))]")
            }
        }
        
        if conditions.count != 0 {
            
            params[kCloudDatasourceConditions] = "{\(conditions.joinWithSeparator(","))}"
        }
        
        return params
    }
    
    func loadData<T>(parameters: [String : AnyObject]?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource {
            
            let url = "\(baseUrl)\(resource)"
            restClient.get(url, parameters: parameters, success: { (response) in
                
                if response is [T] {
                    
                    AnalyticsManager.sharedInstance?.analytics?.logAction("read", entity:String(T))
                    success(response as! [T])
                    
                } else {
                    
                    let error = ErrorManager.mapping(response)
                    AnalyticsManager.sharedInstance?.logger?.log(String(error), level: LoggerLevel.LoggerLevelError)
                    failure(error)
                }
                
            } , failure: failure, progress: progress)
            
        } else {
            
            let error = ErrorManager.invalidUrl()
            AnalyticsManager.sharedInstance?.logger?.log(String(error), level: LoggerLevel.LoggerLevelError)
            failure(error)
        }
    }
}

// MARK: - <Datasource>

extension CloudDatasource : Datasource {
    
    var datasourceFilter: DatasourceFilter {
    
        return filter
    }
    
    func imagePath(path: String?) -> String? {
        
        guard let path = path else {
            return nil
        }
        
        if path.isUrl() {
            
            return path
        }
        
        if let apikey = apikey {
            return "\(baseUrlImage)\(path)?\(kCloudDatasourceApikey)=\(apikey)"
        }
        
        return "\(baseUrlImage)\(path)"
    }

    func refreshData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        //TODO: clear cache
        if let options = options {
            options.skip = 0
        }
        loadData(options, success: success, failure: failure)
    }
    
    func loadData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        var parameters = requestParameters(options)
        if let options = options {
            let skip = options.limit * options.skip
            parameters[kCloudDatasourceSkip] = skip
            parameters[kCloudDatasourceLimit] = options.limit
        }
        loadData(parameters, success: success, failure: failure)
    }
    
    func loadData<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource, identifier = identifier {
            
            let url = "\(baseUrl)\(resource)/\(identifier)"
            restClient.get(url, parameters: nil, success: { (response) in
                
                success(response as? T)
                
            }, failure: failure, progress: progress)
            
        } else {
            
            failure(ErrorManager.invalidUrl())
        }
    }
    
    func distinctValues(name: String, filters: [Filter]?, success: (([String]) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource {
            
            let options = DatasourceOptions()
            if let filters = filters {
                options.designFilters.appendContentsOf(filters)
            }
            var parameters = requestParameters(options)
            parameters[kCloudDatasourceDistinct] = name
            
            let url = "\(baseUrl)\(resource)"
            restClient.get(url, parameters: parameters, success: { (response) in
                
                if response is [String] {
                    
                    success(response as! [String])
                    
                } else {
                    
                    let error = ErrorManager.mapping(response)
                    AnalyticsManager.sharedInstance?.logger?.log(String(error), level: LoggerLevel.LoggerLevelError)
                    failure(error)
                }
                
            }, failure: failure, mapping: false, progress: progress)
            
        } else {
            
            invalidUrl(failure)
        }
    }
}

extension CloudDatasource: CRUD {

    func create<T>(params: [String : AnyObject], success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource {
            
            let url = "\(baseUrl)\(resource)"
            restClient.post(url, parameters: params, success: { (response) in
                
                AnalyticsManager.sharedInstance?.analytics?.logAction("created", entity:String(T))
                success(response as? T)
                
            } , failure: failure, progress: progress)
            
        } else {
            
            invalidUrl(failure)
        }
    }
    
    func read<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        loadData(identifier, success: success, failure: failure)
    }
    
    func update<T>(identifier: AnyObject?, params: [String : AnyObject], success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource, identifier = identifier as? String {
            
            if identifier.isEmpty {
                
                failure(ErrorManager.invalidUrl())
                
            } else {
                
                let url = "\(baseUrl)\(resource)/\(identifier)"
                restClient.put(url, parameters: params, success: { (response) in
                    
                    AnalyticsManager.sharedInstance?.analytics?.logAction("updated", entity:String(T), identifier: String(identifier))
                    
                    success(response as? T)
                    
                } , failure: failure, progress: progress)
            }
            
        } else {
            
            invalidUrl(failure)
        }
    }
    
    func delete<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, resource = resource, identifier = identifier as? String {
            
            if identifier.isEmpty {
                
                failure(ErrorManager.invalidUrl())
            
            } else {
            
                let url = "\(baseUrl)\(resource)/\(identifier)"
                restClient.delete(url, parameters: nil, success: { (response) in
                    
                    AnalyticsManager.sharedInstance?.analytics?.logAction("deleted", entity:String(T), identifier: String(identifier))
                    
                    success(response as? T)
                    
                } , failure: failure, progress: progress)
            }
            
        } else {
            
            invalidUrl(failure)
        }
    }
    
    func invalidUrl(failure: ((NSError?) -> Void)) {
        
        let error = ErrorManager.invalidUrl()
        AnalyticsManager.sharedInstance?.logger?.log(String(error), level: LoggerLevel.LoggerLevelError)
        failure(error)
    }
}