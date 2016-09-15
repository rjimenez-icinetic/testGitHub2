//
//  SearchBehavior.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 3/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class SearchBehavior: NSObject, Behavior {

    var viewController: UIViewController!
    
    var dataDelegate: DataDelegate!
    
    var scrollView: UIScrollView!
    
    var searchBar: UISearchBar!
    
    private let height = Dimens.Sizes.toolbar
    
    init(viewController: UIViewController) {
        super.init()
        self.viewController = viewController
        dataDelegate = self.viewController as? DataDelegate
    }
    
    deinit {
        if let _ = scrollView {
            NSNotificationCenter.defaultCenter().removeObserver(self)
        }
    }
    
    func load() {
        
        if searchBar == nil {
            
            searchBar = UISearchBar(frame: CGRect.zero)
            searchBar.autocorrectionType = .No
            searchBar.tintColor = Style.sharedInstance.toolbarTextColor
            searchBar.barTintColor = Style.sharedInstance.toolbarBackgroundColor
            
            // Hide clear button
            var subviews: [UIView]!
            if searchBar.subviews.count == 1 {
                subviews = searchBar.subviews.first?.subviews
            } else {
                searchBar.subviews
            }
            for view in subviews where view is UITextField {
                (view as! UITextField).clearButtonMode = .Never
                break
            }
        }
        
        if scrollView == nil {
            
            for view in viewController.view.subviews where view is UIScrollView {
                scrollView = view as! UIScrollView
                break
            }
        }
        
        if let _ = dataDelegate {
            
            searchBar.delegate = self
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            
            viewController.view.addSubview(searchBar)
            
            let views:[String: AnyObject] = [
                "topGuide": viewController.topLayoutGuide,
                "searchBar" : searchBar
            ]
            let metrics:[String: CGFloat] = [
                "margin": Dimens.Margins.none,
                "searchBarHeight": height
            ]
            
            viewController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[searchBar]-margin-|",
                options: .DirectionLeadingToTrailing,
                metrics: metrics,
                views: views))
            
            viewController.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[topGuide][searchBar(searchBarHeight)]",
                options: .DirectionLeadingToTrailing,
                metrics: metrics,
                views: views))
            
            if let _ = scrollView {
            
                NSNotificationCenter.defaultCenter().addObserver(self,
                                                                 selector: #selector(rotate),
                                                                 name: UIDeviceOrientationDidChangeNotification,
                                                                 object: nil)
                
                configureInsets()
            }
        }
    }
    
    func rotate() {
        
        configureInsets()
    }
    
    func configureInsets() {
        
        dispatch_async(dispatch_get_main_queue()) {
            
            let top = self.viewController.topLayoutGuide.length
            var scrollInsets = self.scrollView.contentInset
            scrollInsets.top = top + self.height
            self.scrollView.contentInset = scrollInsets
        }
    }
    
    func search(text: String?) {

        viewController.view.endEditing(true)
        var datasourceOptions = dataDelegate.datasourceOptions
        if datasourceOptions == nil {
            datasourceOptions = DatasourceOptions()
        }
        datasourceOptions.searchText = text
        dataDelegate.datasourceOptions = datasourceOptions
        if let _ = text {
            dataDelegate.clearData()
            dataDelegate.loadData()
        } else {
            dataDelegate.refreshData()
        }
    }
}

//MARK: - UISearchBarDelegate

extension SearchBehavior: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        if !searchBar.showsCancelButton {
            searchBar.setShowsCancelButton(true, animated: true)
        }
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        if searchBar.showsCancelButton {
            searchBar.setShowsCancelButton(false, animated: true)
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = nil
        search(nil)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if let text = searchBar.text where !text.trim().isEmpty {
            search(text)
        } else {
            search(nil)
        }
    }
}
