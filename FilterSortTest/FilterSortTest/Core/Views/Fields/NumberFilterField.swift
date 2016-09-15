//
//  NumberFilterField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 2/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

// MARK: - Integer

class IntegerFilterField: IntegerField {
    
    var datasource: Datasource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(datasource: Datasource, name: String, label: String, value: AnyObject?) {
        super.init(name: name, label: label, required: false, value: value)
        self.datasource = datasource
    }
}

extension IntegerFilterField: FilterField {
    
    func filter() -> Filter? {
        
        guard let value = value else {
            return nil
        }
        
        return datasource.datasourceFilter.create(name, number: Double(value as! NSNumber))
    }
}

// MARK: - Decimal

class DecimalFilterField: DecimalField {
    
    var datasource: Datasource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(datasource: Datasource, name: String, label: String, value: AnyObject?) {
        super.init(name: name, label: label, required: false, value: value)
        self.datasource = datasource
    }
}

extension DecimalFilterField: FilterField {
    
    func filter() -> Filter? {
        
        guard let value = value else {
            return nil
        }
        
        return datasource.datasourceFilter.create(name, number: Double(value as! NSNumber))
    }
}