//
//  DatasourceOptions.swift
//  BuildupSDK
//
//  Created by Víctor Jordán Rosado on 19/3/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class DatasourceOptions {

    var skip = 0
    var limit = 50
    var searchText : String?
    
    var sortOptions: [DatasourceSortOptions] = []
    
    var designFilters: [Filter] = []
    
    var filters: [Filter] = []
    
    init() {
        
    }
    
    init(limit: Int) {
    
        self.limit = limit
    }
    
    init(sortOptions: DatasourceSortOptions) {
    
        addSortOptions(sortOptions)
    }
    
    init(limit : Int, sortOptions: DatasourceSortOptions) {
        self.limit = limit
        addSortOptions(sortOptions)
    }
    
    func addDesignFilter(filter: Filter?) {
    
        guard let f = filter else {
            return
        }
        
        designFilters.append(f)
    }
    
    func addFilter(filter: Filter?) {
        
        guard let f = filter else {
            return
        }
        
        filters.append(f)
    }
    
    func clearFilters() {
    
        filters.removeAll()
    }
    
    func addSortOptions(options: DatasourceSortOptions) {
    
        sortOptions.append(options)
    }
    
    func clearSortOptinos() {
    
        sortOptions.removeAll()
    }
}

struct DatasourceSortOptions {

    let field : String?
    let ascending : Bool?
    
    init(field: String?, ascending: Bool?) {

        self.field = field
        self.ascending = ascending
    }
}
