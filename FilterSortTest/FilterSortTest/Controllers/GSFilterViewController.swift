//
//  GSFilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class GSFilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.name,
                label: "name",
                viewController: self),
            
        ]

        loadFields()
    }
}
