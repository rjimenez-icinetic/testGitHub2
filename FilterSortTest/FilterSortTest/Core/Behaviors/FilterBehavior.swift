//
//  FilterBehavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 2/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class FilterBehavior <T: FilterViewController>: NSObject, Behavior {

    var viewController: UIViewController!
    
    var filterViewController: FilterViewController!
    
    var dataDelegate: DataDelegate!
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        dataDelegate = viewController as? DataDelegate
    }
    
    func load() {
    
        if let dataDelegate = dataDelegate {
        
            filterViewController = T()
            filterViewController.title = viewController.title
            filterViewController.filterDelegate = self
            
            filterViewController.datasource = dataDelegate.datasource
            filterViewController.datasourceOptions = dataDelegate.datasourceOptions
            
            let item = UIBarButtonItem(image: UIImage(named: Images.filter), style: .Plain, target: self, action: #selector(openFilter))
            viewController.addBottomItem(item, animated: false)
        }
    }
    
    func appear() {
        
        viewController.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func disappear() {
        
        viewController.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func openFilter() {
        
        let navigationController = UINavigationController(rootViewController: filterViewController)
        viewController.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension FilterBehavior: FilterDelegate {

    func submit(filters: [Filter]?) {
        
        var datasourceOptions = dataDelegate.datasourceOptions
        if datasourceOptions == nil {
            datasourceOptions = DatasourceOptions()
        }
        if let filters = filters {
            datasourceOptions.filters = filters
        } else {
            datasourceOptions.filters.removeAll()
        }
        dataDelegate.datasourceOptions = datasourceOptions
        dataDelegate.clearData()
        dataDelegate.loadData()
    }
}