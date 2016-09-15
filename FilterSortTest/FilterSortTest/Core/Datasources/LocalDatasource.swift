//
//  LocalDatasource.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 7/9/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class LocalDatasource <T:Item> {
    
    private let objectsKey = "objects"
    
    private var items: NSArray = []
    
    private var resource: String!
    
    let filter = LocalDatasourceFilter()
    
    init(resource: String) {
        self.resource = resource
    }
    
    func loadItems() {
    
        if items.count == 0 {
        
            if let path = NSBundle.mainBundle().pathForResource(resource, ofType: "plist"), dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] {
             
                if let objects = dict[objectsKey] as? NSArray {
                    items = objects
                }
            }
        }
    }
    
    func applyFilters(objects: NSArray, filters: [Filter]) -> NSArray {
    
        var predicates: [NSPredicate] = []
        for filter in filters {
            if let f = filter.filter() {
                let predicate = NSPredicate(format: f)
                predicates.append(predicate)
            }
        }
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return objects.filteredArrayUsingPredicate(compoundPredicate)
    }
    
    func query(options: DatasourceOptions?) -> NSArray {
        
        guard let datasourceOptions = options else {
            
            return items
        }
        
        var objects: NSArray = []
        
        // Runtime filters
        objects = applyFilters(items, filters: datasourceOptions.filters)
        
        // Design filters
        objects = applyFilters(objects, filters: datasourceOptions.designFilters)
        
        // Search text
        if let searchText = datasourceOptions.searchText {
            if objects.count > 0 {
                if let dictionary = objects[0] as? NSDictionary {
                    let keys = Array(dictionary.allKeys)
                    var predicates: [NSPredicate] = []
                    for key in keys {
                        let predicate = NSPredicate(format: "\(key) contains[cd] '\(searchText)'")
                        predicates.append(predicate)
                    }
                    let compoundPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
                    objects = objects.filteredArrayUsingPredicate(compoundPredicate)
                }
            }
        }
        
        // Sort options
        if datasourceOptions.sortOptions.count != 0 {
            
            let sortOptions = datasourceOptions.sortOptions[0]
            if let sortField = sortOptions.field, let sortAscending = sortOptions.ascending {

                let sortDescriptor = NSSortDescriptor(key: sortField, ascending: sortAscending)
                objects = objects.sortedArrayUsingDescriptors([sortDescriptor])
            }
        }
        
        // Pagination
        let offset = datasourceOptions.skip * datasourceOptions.limit
        let blockSize = datasourceOptions.limit
        var range = NSMakeRange(offset, blockSize)
        if range.location < objects.count {
            range = NSMakeRange(range.location, min(objects.count - range.location, range.length))
            objects = objects.subarrayWithRange(range)
        } else {
            objects = []
        }
        
        return objects
    }
    
    func mapping(objects: NSArray) -> [T] {
    
        var result: [T] = []
        for dictionary in objects {
            if let dictionary = dictionary as? NSDictionary,
                item = T(dictionary: dictionary)
                where item.identifier != nil {
                
                result.append(item)
            }
        }
        
        return result
    }
}

// MARK: - <Datasource>

extension LocalDatasource : Datasource {
    
    var datasourceFilter: DatasourceFilter {
        
        return filter
    }
    
    func imagePath(path: String?) -> String? {
        
        guard let path = path else {
            return nil
        }
        
        return path
    }
    
    func refreshData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        //TODO: clear cache
        if let options = options {
            options.skip = 0
        }
        loadData(options, success: success, failure: failure)
    }
    
    func loadData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            self.loadItems()
            let objects = self.query(options)
            let items = self.mapping(objects)
            
            dispatch_async(dispatch_get_main_queue()) {
                
                var response: [T] = []
                for item in items where item is T {
                    response.append(item as! T)
                }
                success(response)
            }
        }
    }
    
    func loadData<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            self.loadItems()
            let response = self.mapping(self.items)
            let item = response.filter { ($0.identifier as? String) == (identifier as? String)}
            
            dispatch_async(dispatch_get_main_queue()) {
                
                success(item as? T)
            }
        }
    }
    
    func distinctValues(name: String, filters: [Filter]?, success: (([String]) -> Void), failure: ((NSError?) -> Void)) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            self.loadItems()
            var objects = self.items
            if let filters = filters {
                objects = self.applyFilters(self.items, filters: filters)
            }
            
            var response:[String] = []
            for dictionary in objects {
                if let value = dictionary[name] as? String {
                    response.append(value)
                }
            }
            
            dispatch_async(dispatch_get_main_queue()) {
                
                success(response)
            }
        }
    }
}
