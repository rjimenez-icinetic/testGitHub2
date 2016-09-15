//
//  LocalListFilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class LocalListFilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: DoubleFilterLocalDSSchemaItemMapping.text1,
                label: "Text1",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: DoubleFilterLocalDSSchemaItemMapping.text2,
                label: "Text2",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: DoubleFilterLocalDSSchemaItemMapping.text3,
                label: "Text3",
                viewController: self),
            
        ]

        loadFields()
    }
}
