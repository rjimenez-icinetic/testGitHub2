//
//  CreateBehavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 8/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit
import SVProgressHUD

class CreateBehavior<U: FormViewController, T:Item>: NSObject, Behavior {

    var viewController: UIViewController!
    
    var formViewController: FormViewController!
    
    var dataDelegate: DataDelegate!
 
    var crudService: CRUD!
    
    var syncService: Synchronize!
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        dataDelegate = viewController as? DataDelegate
        crudService = dataDelegate?.datasource as? CRUD
        syncService = dataDelegate?.datasource as? Synchronize
    }
    
    func load() {
        
        if let crudService = crudService {
            
            formViewController = U()
            formViewController.title = viewController.title
            formViewController.formDelegate = self
            
            formViewController.crudService = crudService
            
            let item = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(openForm))
            viewController.addBottomItem(item, animated: false)
        }
    }
    
    func appear() {
        viewController.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func disappear() {
        viewController.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func openForm() {
        let navigationController = UINavigationController(rootViewController: formViewController)
        viewController.presentViewController(navigationController, animated: true, completion: nil)
    }
}

extension CreateBehavior: FormDelegate {

    func submit(fields: [String : AnyObject]?) {
        
        formViewController.clear()
        formViewController.formValues.removeAll()
        if let fields = fields {
        
            SVProgressHUD.show()
            
            crudService.create(fields, success: { [weak self] (response: T?) in
                
                guard let strongSelf = self else { return }
                
                SVProgressHUD.showSuccessWithStatus(nil)
                strongSelf.dataDelegate.clearData()
                strongSelf.dataDelegate.loadData()
                
                if let syncService = strongSelf.syncService {
                    syncService.sync()
                }
                
            }) { [weak self] (error) in
            
                SVProgressHUD.dismiss()
                guard let strongSelf = self else { return }
                
                ErrorManager.show(error, rootController: strongSelf.viewController)
            }
        }
    }
}
