//
//  LocalMenuItem5FilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class LocalMenuItem5FilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: LocalDSDSSchemaItemMapping.text1,
                label: "Text1",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: LocalDSDSSchemaItemMapping.text2,
                label: "Text2",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: LocalDSDSSchemaItemMapping.text3,
                label: "Text3",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: LocalDSDSSchemaItemMapping.createAt,
                label: "CreateAt",
                viewController: self),
            
        ]

        loadFields()
    }
}
