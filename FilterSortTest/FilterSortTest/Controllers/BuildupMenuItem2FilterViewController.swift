//
//  BuildupMenuItem2FilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class BuildupMenuItem2FilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: BuildupCloudDSDSItemMapping.text1,
                label: "Text1",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: BuildupCloudDSDSItemMapping.text2,
                label: "Text2",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: BuildupCloudDSDSItemMapping.text3,
                label: "Text3",
                viewController: self),
            
        ]

        loadFields()
    }
}
