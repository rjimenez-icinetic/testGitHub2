//
//  ExternalDatasource.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/7/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class ExternalDatasource <T:Item> {
    
    let kExternalDatasourceApikey       = "apiKey"
    let kExternalDatasourceSort         = "sortingColumn"
    let kExternalDatasourceSortType     = "sortAscending"
    let kExternalDatasourceSkip         = "offset"
    let kExternalDatasourceLimit        = "blockSize"
    let kExternalDatasourceSearch       = "searchText"
    let kExternalDatasourceConditions   = "condition"
    let kExternalDatasourceDistinct     = "distinct"
    
    var identifier: String?
    var baseUrl: String?
    var appIdentifier: String?
    var apikey: String?
    
    var restClient: HttpClient<T>
    
    var progress:((Int64, Int64, Int64) -> Void)?
    
    let filter = ExternalDatasourceFilter()

    init(identifier: String, baseUrl: String, appIdentifier: String, apikey: String) {
        
        self.identifier = identifier
        self.baseUrl = baseUrl
        self.appIdentifier = appIdentifier
        self.apikey = apikey
        restClient = HttpClient<T>()
        restClient.user = appIdentifier
        restClient.password = apikey
    }
    
    func requestParameters(options: DatasourceOptions?) -> [String : AnyObject] {
        
        var params: [String: AnyObject] = [:]
        
        guard let datasourceOptions = options else {
            
            return params
        }
        
        let skip = datasourceOptions.limit * datasourceOptions.skip
        
        params[kExternalDatasourceSkip] = skip
        
        params[kExternalDatasourceLimit] = datasourceOptions.limit
        
        // Sort options
        if datasourceOptions.sortOptions.count != 0 {
            
            let sortOptions = datasourceOptions.sortOptions[0]
            if let sortField = sortOptions.field,
                let sortAscending = sortOptions.ascending {

                params[kExternalDatasourceSort] = sortField
                params[kExternalDatasourceSortType] = sortAscending ? "true" : "false"
            }
        }
        
        var conditions: [String] = []
        
        // Search text
        if let searchText = datasourceOptions.searchText {
            params[kExternalDatasourceSearch] = searchText
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
            
            params[kExternalDatasourceConditions] = "{\(conditions.joinWithSeparator(","))}"
        }
        
        return params
    }
    
    func loadData<T>(parameters: [String : AnyObject]?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, identifier = identifier {
            let url = "\(baseUrl)/\(identifier)"
            
            restClient.get(url, parameters: parameters, success: { (response) in
                
                if let response = response as? [T] {
                    
                    success(response)
                    
                } else {
                    
                    failure(ErrorManager.mapping(response))
                }
                
            } , failure: failure, progress: progress)
            
        } else {
            
            failure(ErrorManager.invalidUrl())
        }
    }
}

// MARK: - <Datasource>

extension ExternalDatasource : Datasource {
    
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
            return "\(baseUrl)\(path)?\(kExternalDatasourceApikey)=\(apikey)"
        }
        
        return "\(baseUrl)\(path)"
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
            parameters[kExternalDatasourceSkip] = skip
            parameters[kExternalDatasourceLimit] = options.limit
        }
        loadData(parameters, success: success, failure: failure)
    }
    
    func loadData<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, dsIdentifier = self.identifier, identifier = identifier {
            
            let url = "\(baseUrl)\(dsIdentifier)/\(identifier)"
            restClient.get(url, parameters: nil, success: { (response) in
                
                success(response as? T)
                
            }, failure: failure, progress: progress)
            
        } else {
            
            failure(ErrorManager.invalidUrl())
        }
    }
    
    func distinctValues(name: String, filters: [Filter]?, success: (([String]) -> Void), failure: ((NSError?) -> Void)) {
        
        if let baseUrl = baseUrl, identifier = identifier {
            
            let options = DatasourceOptions()
            if let filters = filters {
                options.designFilters.appendContentsOf(filters)
            }
            let parameters = requestParameters(options)
            
            let url = "\(baseUrl)/\(identifier)/\(kExternalDatasourceDistinct)/\(name)"
            restClient.get(url, parameters: parameters, success: { (response) in
                
                if response is [String] {
                    
                    success(response as! [String])
                    
                } else {
                    
                    failure(ErrorManager.mapping(response))
                }
                
            }, failure: failure, mapping: false, progress: progress)
            
        } else {
            
            failure(ErrorManager.invalidUrl())
        }
    }
}