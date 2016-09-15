//
//  DataViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 10/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DataViewController<T: Item>: UIViewController, DataDelegate {

    var behaviors:[Behavior] = []
    
    var item: T?
    
    var actions:[Int: Action] = [:]
    
    var datasource: Datasource!
    
    var datasourceOptions: DatasourceOptions!
    
    var indicatorView: UIActivityIndicatorView?
    
    var dataResponse: DataResponse?

    var mainConstraints: [NSLayoutConstraint] = []
    var scrollConstraints: [NSLayoutConstraint] = []
    var contentConstraints: [NSLayoutConstraint] = []
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.sharedInstance.backgroundColor
        
        scrollView = UIScrollView()
        scrollView.scrollsToTop = true
        view.addSubview(scrollView)
        
        contentView = UIView()
        contentView.backgroundColor = UIColor.clearColor()
        scrollView.addSubview(contentView)
        
        indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,
            y: 0,
            width: Double(Dimens.Sizes.large),
            height: Double(Dimens.Sizes.large)))
        indicatorView?.activityIndicatorViewStyle = .White
        indicatorView?.hidesWhenStopped = true
        view.setBackgroundView(indicatorView)
        
        datasourceOptions = DatasourceOptions()
        
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: #selector(refreshData))
        navigationItem.rightBarButtonItem = refreshButton
        
        for behavior in behaviors {
            behavior.load()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        for behavior in behaviors  {
            behavior.appear?()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        for behavior in behaviors {
            behavior.disappear?()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        for view in contentView.subviews where view is UIImageView {
            
            (view as! UIImageView).fixHeight(view.bounds)
        }
    }
    
    func addSubview(view: UIView?) {
    
        guard let view = view else {
            return
        }
        view.tag = contentView.subviews.count + 1
        contentView.addSubview(view)
    }
    
    func createLabel(font: UIFont? = Style.sharedInstance.font, textColor: UIColor? = Style.sharedInstance.foregroundColor, alignment: NSTextAlignment? = NSTextAlignment.Left, text: String? = nil) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.font = font
        label.textColor = textColor
        label.textAlignment = alignment ?? NSTextAlignment.Left
        label.text = text
        return label
    }
    
    func createHeaderLabel(text: String) -> UILabel {
        
        return createLabel(textColor: Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.label), text: text)
    }
    
    func createImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        return imageView
    }
    
    func createButton(image: String) -> UIButton {
        
        let button = UIButton(type: .System)
        button.setTitleColor(Style.sharedInstance.foregroundColor, forState: .Normal)
        button.setImage(UIImage(named: image), forState: .Normal)
        button.tintColor = Style.sharedInstance.foregroundColor
        return button
    }
    
    func setAction(action: Action, view: UIView) {
    
        if let button = view as? UIButton {
    
            button.removeTarget(self, action: #selector(handlerAction), forControlEvents: .TouchUpInside)
            button.addTarget(self, action: #selector(handlerAction), forControlEvents: .TouchUpInside)
            
        } else {
        
            view.gestureRecognizers?.removeAll()
            let tap = UITapGestureRecognizer(target: self, action: #selector(handlerAction))
            tap.numberOfTapsRequired = 1
            view.addGestureRecognizer(tap)
        }
        actions[view.tag] = action
    }
    
    func handlerAction(obj: AnyObject) {
        
        var tag = 0
        if let tap = obj as? UIGestureRecognizer {
            tag = (tap.view?.tag)!
        } else if let view = obj as? UIView {
            tag = view.tag
        }
        if let action = actions[tag] where action.canBeExecuted() {
            action.execute()
        }
    }
    
    //MARK: - Data
    
    func clearData() {
        
        item = nil
    }
    
    func refreshData() {
        
        contentView.hidden = true
        scrollView.setContentOffset(CGPointMake(0.0, -scrollView.contentInset.top), animated:false)
        if let item = item {
            clearData()
            indicatorView?.startAnimating()
            datasource?.loadData(item.identifier, success: { (response: T?) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.indicatorView?.stopAnimating()
                    self.loadDataSuccess(response)
                }
                
            }, failure: { (error: NSError?) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.indicatorView?.stopAnimating()
                    self.loadDataFailure(error)
                }
            })
        } else {
            clearData()
            loadData()
        }
    }
    
    func loadData() {
        
        contentView.hidden = true
        if let item = item {
            loadDataSuccess(item)
        } else {
            indicatorView?.startAnimating()
            datasource?.loadData(datasourceOptions, success: { (response: [T]) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.indicatorView?.stopAnimating()
                    if response.count != 0 {
                        self.loadDataSuccess(response[0])
                    } else {
                        self.loadDataSuccess(nil)
                    }
                }
                
            }, failure: { (error: NSError?) in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.indicatorView?.stopAnimating()
                    self.loadDataFailure(error)
                }
            })
        }
    }
    
    func loadDataSuccess(response: T?) {
        
        contentView.hidden = false
        item = response
        dataResponse?.success()
    }
    
    func loadDataFailure(error: NSError?) {
        
        dataResponse?.failure(error)
    }
}