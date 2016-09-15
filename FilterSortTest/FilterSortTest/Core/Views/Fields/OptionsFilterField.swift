//
//  OptionsFilterField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class OptionsFilterField: OptionsField {
    
    var datasource: Datasource!
    var datasourceOptions: DatasourceOptions?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(datasource: Datasource, datasourceOptions: DatasourceOptions?, name: String, label: String, viewController: UIViewController, options: [String : String]? = nil, value: AnyObject? = nil) {
        super.init(name: name, label: label, required: false, viewController: viewController, options: options, value: value)
        self.datasource = datasource
        self.datasourceOptions = datasourceOptions
        
        if options == nil {

            populate = {

                self.loading(true)
                datasource.distinctValues(name, filters: datasourceOptions?.designFilters, success: { (response) in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        self.options = [:]
                        for option in response {
                            self.options![option] = option
                        }
                        self.showOptions()
                        self.loading(false)
                    }
                    
                }, failure: { (error) in
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        ErrorManager.show(error, rootController: viewController)
                        self.loading(false)
                    }
                })
            }
        }
    }
}

extension OptionsFilterField: FilterField {
    
    func filter() -> Filter? {
        
        guard let value = value, let options = value as? [String: String] else {
            return nil
        }
        
        return datasource.datasourceFilter.create(name, stringList: Array(options.keys))
    }
}