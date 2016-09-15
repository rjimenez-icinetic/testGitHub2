//
//  ExcelMenuItem1FilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class ExcelMenuItem1FilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1Schema1ItemMapping.column3,
                label: "Column3",
                viewController: self),
            
        ]

        loadFields()
    }
}
