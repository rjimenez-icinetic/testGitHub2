//
//  DeleteBehavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 16/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit
import SVProgressHUD

class DeleteBehavior<T: Item>: NSObject, Behavior {

    var dataViewController: DataViewController<T>!
    
    var crudService: CRUD!
    
    var syncService: Synchronize!
    
    init(dataViewController: DataViewController<T>) {
        super.init()
        self.dataViewController = dataViewController
        crudService = dataViewController.datasource as? CRUD
        syncService = dataViewController.datasource as? Synchronize
    }
    
    func load() {
        
        if let _ = crudService, _ = dataViewController.item?.identifier {
            
            let button = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(removeAction))
            dataViewController.addBottomItem(button, animated: false)
        }
    }
    
    func appear() {
        dataViewController.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func disappear() {
        dataViewController.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func removeAction() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Remove", comment: ""), style: .Destructive, handler: { (action) in
            
            self.removeItem()
        }))
        dataViewController.presentViewController(alertController, animated: true, completion: nil)
    }

    func removeItem() {
    
        if let identifier = dataViewController.item?.identifier {
        
            SVProgressHUD.show()
            
            crudService.delete(identifier, success: { [weak self] (response: T?) in
                
                dispatch_async(dispatch_get_main_queue()) {
                
                    guard let strongSelf = self else { return }
                    
                    SVProgressHUD.showSuccessWithStatus(nil)
                    
                    let navigationController = strongSelf.dataViewController.navigationController
                    navigationController?.popViewControllerAnimated(true)
                    
                    if let dataDelegate = navigationController?.topViewController as? DataDelegate {
                        dataDelegate.clearData()
                        dataDelegate.loadData()
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
