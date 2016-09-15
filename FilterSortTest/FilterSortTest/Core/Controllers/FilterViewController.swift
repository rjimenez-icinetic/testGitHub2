//
//  FilterViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public protocol FilterDelegate {
    
    func submit(filters: [Filter]?)
}

class FilterViewController: InputViewController {

    var datasource: Datasource!
    var datasourceOptions: DatasourceOptions?
    
    var filterFields: [FilterField]!
    
    var filterDelegate: FilterDelegate!
    
    var filterValues: [String: AnyObject] = [:]
    
    var submitButton: UIButton!
    
    private let buttonHeight = Dimens.Sizes.toolbar
    
    override required init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let closeItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem = closeItem
        
        let resetItem = UIBarButtonItem(title: NSLocalizedString("Clear", comment: ""), style: .Plain, target: self, action: #selector(clearAction))
        navigationItem.rightBarButtonItem = resetItem

        submitButton = UIButton(type: .Custom)
        submitButton.setTitle(NSLocalizedString("Apply", comment: ""), forState: .Normal)
        submitButton.titleLabel?.font = Style.sharedInstance.font
        submitButton.tintColor = Style.sharedInstance.toolbarTextColor
        submitButton.backgroundColor = Style.sharedInstance.toolbarBackgroundColor
        submitButton.setTitleColor(Style.sharedInstance.toolbarTextColor, forState: .Normal)
        submitButton.setTitleColor(Style.sharedInstance.selectedColor, forState: .Highlighted)
        
        submitButton.addTarget(self, action: #selector(submitAction), forControlEvents: .TouchUpInside)
        view.addSubview(submitButton)
        
        dispatch_async(dispatch_get_main_queue()) {
            
            var insets = self.scrollInsets
            insets.bottom += self.buttonHeight
            self.scrollInsets = insets
            
            self.scrollView.contentInset = self.scrollInsets
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["submitButton": submitButton]
        let metrics = ["buttonHeight": buttonHeight]
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[submitButton]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[submitButton(buttonHeight)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
    }
    
    func loadFields() {
    
        if let filterFields = filterFields {
            for filterField in filterFields {
                contentView.addSubview(filterField as! UIView)
                if let value = filterField.value {
                    filterValues[filterField.name] = value
                }
            }
        }
        updateViewConstraints()
    }
    
    func cancelAction() {
        if let filterFields = filterFields {
            for var filterField in filterFields {
                filterField.value = filterValues[filterField.name]
                filterField.reset()
            }
        }
        close()
    }
    
    func clearAction() {
        if let filterFields = filterFields {
            for filterField in filterFields {
                filterField.clear()
            }
        }
    }
    
    func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func submitAction() {
        if let filterDelegate = filterDelegate {
            filterValues.removeAll()
            var filters: [Filter] = []
            if let filterFields = self.filterFields {
                for filterField in filterFields {
                    let filter = filterField.filter()
                    if  let filter = filter {
                        filters.append(filter)
                    }
                    if let value = filterField.value {
                        filterValues[filterField.name] = value
                    }
                }
            }
            filterDelegate.submit(filters)
        }
        close()
    }
}