//
//  StringFilterField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

class StringFilterField: StringField {
    
    var datasource: Datasource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(datasource: Datasource, name: String, label: String, value: AnyObject?) {
        super.init(name: name, label: label, required: false, value: value)
        self.datasource = datasource
    }
}

extension StringFilterField: FilterField {
    
    func filter() -> Filter? {
        
        guard let value = value else {
            return nil
        }
        
        return datasource.datasourceFilter.create(name, string: value as! String)
    }
}