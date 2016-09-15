//
//  UpdateBehavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 10/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

import SVProgressHUD

class UpdateBehavior<U: FormViewController, T: Item>: NSObject, Behavior {
    
    var dataViewController: DataViewController<T>!
    
    var formViewController: FormViewController!
    
    var crudService: CRUD!

    var syncService: Synchronize!
    
    init(dataViewController: DataViewController<T>) {
        super.init()
        self.dataViewController = dataViewController
        crudService = dataViewController.datasource as? CRUD
        syncService = dataViewController.datasource as? Synchronize
    }

    deinit {
        dataViewController = nil
        formViewController = nil
    }
    
    func load() {
        
        if let crudService = crudService {
            
            formViewController = U()
            formViewController.title = dataViewController.title
            formViewController.formDelegate = self
            
            formViewController.crudService = crudService
            
            let button = UIBarButtonItem(barButtonSystemItem: .Compose, target: self, action: #selector(openForm))
            if dataViewController.navigationItem.rightBarButtonItems == nil {
               dataViewController.navigationItem.rightBarButtonItems = []
            }
            dataViewController.navigationItem.rightBarButtonItems?.append(button)
        }
    }
    
    func openForm() {
        
        formViewController.item = dataViewController.item
        let navigationController = UINavigationController(rootViewController: formViewController)
        dataViewController.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension UpdateBehavior: FormDelegate {
    
    func submit(fields: [String : AnyObject]?) {
        
        if let fields = fields, crudService = crudService, identifier = dataViewController.item?.identifier {
            
            SVProgressHUD.show()
            
            crudService.update(identifier, params: fields, success: { [weak self] (response: T?) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    guard let strongSelf = self else { return }
                    
                    SVProgressHUD.showSuccessWithStatus(nil)
                    
                    let navigationController = strongSelf.dataViewController.navigationController
                    navigationController?.popViewControllerAnimated(false)
                    
                    if let dataDelegate = navigationController?.topViewController as? DataDelegate {
                        dataDelegate.clearData()
                        dataDelegate.loadData()
                    } else {
                        strongSelf.dataViewController.clearData()
                        strongSelf.dataViewController.item = response
                        strongSelf.dataViewController.loadData()
                    }

                    if let syncService = strongSelf.syncService {
                        syncService.sync()
                    }
                }
                
            }) { [weak self] (error) in
                
                SVProgressHUD.dismiss()
                guard let strongSelf = self else { return }
                
                ErrorManager.show(error, rootController: strongSelf.dataViewController)   
            }
        }
    }
}

