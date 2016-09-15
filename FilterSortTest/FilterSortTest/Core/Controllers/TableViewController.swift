//
//  TableViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 28/7/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class TableViewController<T>: DataSetViewController<T> {

    var tableView: UITableView!
    
    var style:UITableViewStyle = .Plain
    
    var didSetupContraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var refreshControl: UIRefreshControl!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
    }
    
    init(style: UITableViewStyle) {
        super.init()
        self.style = style
    }
    
    deinit {
        if tableView.superview != nil {
            tableView.removeFromSuperview()
        }
        tableView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.sharedInstance.backgroundColor
        
        if tableView == nil {
            tableView = UITableView(frame: CGRect.zero, style: style)
        }
        
        view.addSubview(tableView)
        
        tableView.layoutMargins = UIEdgeInsetsZero
        if #available(iOS 9.0, *) {
            tableView.cellLayoutMarginsFollowReadableWidth = false
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        
        for behavior in behaviors {
            behavior.load()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupContraints {
            didSetupContraints = true
            setupConstraints()
        }
        super.updateViewConstraints()
    }
    
    override func refreshData() {
        
        clearData()
        refreshControl.beginRefreshing()
        datasource?.refreshData(datasourceOptions, success: { (response: [T]) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.refreshControl.endRefreshing()
                self.loadDataSuccess(response)
            }
            
        }) { (error: NSError?) in
            
            dispatch_async(dispatch_get_main_queue()) {
                
                self.refreshControl.endRefreshing()
                self.loadDataFailure(error)
            }
        }
    }
    
    func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views:[String: AnyObject] = [
            "tableView" : tableView
        ]
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[tableView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: views))
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[tableView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: views))
        
        view.addConstraints(mainConstraints)
    }
}