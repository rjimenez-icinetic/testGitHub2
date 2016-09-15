//
//  Datasource.swift
//  BuildupSDK
//
//  Created by Víctor Jordán Rosado on 19/3/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

protocol Datasource {
    
    var datasourceFilter: DatasourceFilter { get }
    
    func imagePath(path: String?) -> String?
    
    func refreshData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void))
    
    func loadData<T>(options: DatasourceOptions?, success: (([T]) -> Void), failure: ((NSError?) -> Void))
    
    func loadData<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void))
    
    func distinctValues(name: String, filters: [Filter]?, success: (([String]) -> Void), failure: ((NSError?) -> Void))
}

protocol DataDelegate {
    
    var datasource: Datasource! { get }
    
    var datasourceOptions: DatasourceOptions! { get set }
    
    var dataResponse: DataResponse? { get set }

    func clearData()
    
    func refreshData()
    
    func loadData()
}

protocol DataResponse {
    
    func success()
    
    func failure(error: NSError?)
}

protocol CRUD: Datasource {

    func create<T>(params: [String: AnyObject], success: ((T?) -> Void), failure: ((NSError?) -> Void))
    
    func read<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void))
    
    func update<T>(identifier: AnyObject?, params: [String: AnyObject], success: ((T?) -> Void), failure: ((NSError?) -> Void))
    
    func delete<T>(identifier: AnyObject?, success: ((T?) -> Void), failure: ((NSError?) -> Void))
}

protocol Synchronize {

    func sync()
}