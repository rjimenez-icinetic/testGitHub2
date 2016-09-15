//
//  GSListFilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class GSListFilterViewController: FilterViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterFields = [
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.name,
                label: "name",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.location,
                label: "location",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.lastReview,
                label: "lastReview",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.review,
                label: "review",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.reviewDate,
                label: "reviewDate",
                viewController: self),
			OptionsFilterField(datasource: datasource,
                datasourceOptions: datasourceOptions,
                name: Hoja1ItemMapping.picture,
                label: "picture",
                viewController: self),
            
        ]

        loadFields()
    }
}
