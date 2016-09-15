//
//  MainNavigation.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//
 
import Foundation
import SlideMenuControllerSwift

class MainNavigation {

    var rootViewController: UIViewController!
    
    lazy var slideMenuController: SlideMenuController! = {
        
        let mainViewController = BasicFilterViewController()
        mainViewController.addLeftBarButtonWithImage(UIImage(named: Images.navMenu)!)
        let mainNavigationController = UINavigationController(rootViewController: mainViewController)
        
        let menuViewController = MainMenuViewController()
        let menuNavigationController = UINavigationController(rootViewController: menuViewController)
        
        return SlideMenuController(mainViewController: mainNavigationController, leftMenuViewController: menuNavigationController)
    }()

	
	init() {
        
        self.rootViewController = slideMenuController
    }
		
}
