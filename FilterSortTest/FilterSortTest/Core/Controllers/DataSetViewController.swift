//
//  DataSetViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 21/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DataSetViewController<T>: UIViewController, DataDelegate {

    var behaviors: [Behavior] = []
    
    var items: [T] = []
    
    var datasource: Datasource!
    
    var datasourceOptions: DatasourceOptions!
    
    var pageNumber = 0
    
    var loadMore = false
    
    var indicatorView: UIActivityIndicatorView?
    
    var dataResponse: DataResponse?

    init() {
        super.init(nibName: nil, bundle: nil)
        datasourceOptions = DatasourceOptions()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        datasourceOptions = DatasourceOptions()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,
            y: 0,
            width: Double(Dimens.Sizes.large),
            height: Double(Dimens.Sizes.large)))
        indicatorView?.activityIndicatorViewStyle = .White
        indicatorView?.hidesWhenStopped = true
        view.setBackgroundView(indicatorView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        for behavior in behaviors {
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
    
    //MARK: - Data
    
    func clearData() {
        
        pageNumber = 0
        loadMore = true
        items.removeAll()
    }
    
    func refreshData() {
        
        clearData()
        indicatorView?.startAnimating()
        datasourceOptions.skip = pageNumber
        datasource?.refreshData(datasourceOptions, success: { (response: [T]) in
            
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
    }
    
    func loadData() {
        
        indicatorView?.startAnimating()
        datasourceOptions.skip = pageNumber
        datasource?.loadData(datasourceOptions, success: { (response: [T]) in
            
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
    }
    
    func loadMoreData(index: Int) {
        
        if loadMore && index == items.count - 1 {
            
            loadData()
        }
    }
    
    func loadDataSuccess(response: [T]) {
        
        if response.count != 0 {
            
            pageNumber = pageNumber + 1
            
            items.appendContentsOf(response)
            
            loadMore = items.count % datasourceOptions.limit == 0
            
        } else {
            
            loadMore = false
        }
        
        dataResponse?.success()
    }
    
    func loadDataFailure(error: NSError?) {
        
        dataResponse?.failure(error)
    }
}
