//
//  StackViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 30/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    var scrollConstraints: [NSLayoutConstraint] = []
    var contentConstraints: [NSLayoutConstraint] = []
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.sharedInstance.backgroundColor
        
        scrollView = UIScrollView()
        scrollView.keyboardDismissMode = .Interactive
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(contentView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        
        if !didSetupConstraints {
            
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateViewConstraints()
    }
    
    func setupConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.removeConstraints(contentConstraints)
        scrollView.removeConstraints(scrollConstraints)
        view.removeConstraints(mainConstraints)
        
        var views:[String: UIView] = [
            "scrollView": scrollView,
            "contentView": contentView
        ]
        
        let metrics = [
            "zero": Dimens.Margins.none,
            "margin": Dimens.Margins.large
        ]
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        scrollConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView(==scrollView)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        scrollConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        let n = contentView.subviews.count
        if n != 0 {
            
            var verticalConstraints = "V:|"
            var i = 0
            while i < n {
                
                let view = contentView.subviews[i]
                view.translatesAutoresizingMaskIntoConstraints = false
                let viewKey = "field\(i)"
                views[viewKey] = view
                
                contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[\(viewKey)]|",
                    options: .DirectionLeadingToTrailing,
                    metrics: metrics,
                    views: views))
                
                verticalConstraints.appendContentsOf("[\(viewKey)]")
                
                i += 1
            }
            verticalConstraints.appendContentsOf("-(>=zero)-|")
            
            contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat(verticalConstraints,
                options: .DirectionLeadingToTrailing,
                metrics: metrics,
                views: views))
        }
        
        view.addConstraints(mainConstraints)
        contentView.addConstraints(contentConstraints)
        scrollView.addConstraints(scrollConstraints)
    }    
}