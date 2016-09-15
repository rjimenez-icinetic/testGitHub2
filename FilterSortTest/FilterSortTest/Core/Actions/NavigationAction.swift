//
//  NavigationAction.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 18/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

enum NavigationType {

    case Auto
    case Sliding
    case Push
    case Modal
}

struct NavigationAction<T: UIViewController>: Action {

    var rootViewController: UIViewController!
    var type: NavigationType!
    
    init(rootViewController: UIViewController, type: NavigationType? = .Push) {
    
        self.rootViewController = rootViewController
        self.type = type
    }
    
    func execute() {
        
        AnalyticsManager.sharedInstance?.analytics?.logAction("navigate", target: String(type))
        switch type as NavigationType {
        case .Sliding:
            navigationSliding()
            break
        case .Push:
            navigationPush()
            break
        case .Modal:
            navigationModal()
            break
        default:
            navigationAuto()
            break
        }
    }
    
    func canBeExecuted() -> Bool {
        
        return rootViewController != nil
    }
    
    private func mainViewController() -> UIViewController {
    
        let mainViewController = T()
        mainViewController.addLeftBarButtonWithImage(UIImage(named: Images.navMenu)!)
        return mainViewController
    }
    
    private func navigationAuto() {
    
        if rootViewController.slideMenuController() != nil {
        
            navigationSliding()
        
        } else if rootViewController.navigationController != nil {
        
            navigationPush()
        
        } else {
        
            navigationModal()
        }
    }
    
    private func navigationSliding() {
    
        if let mainNavigationController = rootViewController.slideMenuController()?.mainViewController as? UINavigationController {
            
            if mainNavigationController.topViewController is T {
                
                rootViewController.slideMenuController()?.closeLeft()
                
            } else {
                
                let navigationController = UINavigationController(rootViewController: mainViewController())
                rootViewController.slideMenuController()?.changeMainViewController(navigationController, close: true)
            }
            
        } else {
            
            rootViewController.slideMenuController()?.changeMainViewController(mainViewController(), close: true)
        }
    }
    
    private func navigationPush() {
        
        rootViewController.navigationController?.pushViewController(T(), animated: true)
    }
    
    private func navigationModal() {
        
        rootViewController.presentViewController(T(),
                                                 animated: true,
                                                 completion: nil)
    }
}