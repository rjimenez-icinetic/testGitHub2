//
//  ExcelDetailViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class ExcelDetailViewController: DataViewController<Hoja1Schema1Item> {
    
    var didSetupConstraints = false
   
	var titleLabel1Header: UILabel!
	var titleLabel1: UILabel!
	var titleLabel2Header: UILabel!
	var titleLabel2: UILabel!
	var titleLabel3Header: UILabel!
	var titleLabel3: UILabel!
	

	override init() {
        super.init()
        
        datasource = DatasourceManager.sharedInstance.ExcelOnlineScreen1DS
        
        dataResponse = self

		behaviors.append(ShareBehavior(dataViewController: self))
	
    }
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
		titleLabel1Header = createHeaderLabel("Column1")
		addSubview(titleLabel1Header)	
		
		titleLabel1 = createLabel()
		addSubview(titleLabel1)	
		
		titleLabel2Header = createHeaderLabel("Column2")
		addSubview(titleLabel2Header)	
		
		titleLabel2 = createLabel()
		addSubview(titleLabel2)	
		
		titleLabel3Header = createHeaderLabel("Column3")
		addSubview(titleLabel3Header)	
		
		titleLabel3 = createLabel()
		addSubview(titleLabel3)	
		
	
		updateViewConstraints()
		
		loadData()
	}
    
    override func updateViewConstraints() {
        
        if !didSetupConstraints {
            
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateViewConstraints()
    }

	func setupConstraints() {
        
        let views:[String: UIView] = [
            "scrollView": scrollView,
            "contentView": contentView,
			"titleLabel1Header": titleLabel1Header, 
			"titleLabel1": titleLabel1,
			"titleLabel2Header": titleLabel2Header, 
			"titleLabel2": titleLabel2,
			"titleLabel3Header": titleLabel3Header, 
			"titleLabel3": titleLabel3,
        ]
        
        let metrics:[String: CGFloat] = [
            "zero": Dimens.Margins.none,
            "margin": Dimens.Margins.large,
            "buttonSize": Dimens.Sizes.small
        ]
		
		contentView.removeConstraints(contentConstraints)
        scrollView.removeConstraints(scrollConstraints)
        view.removeConstraints(mainConstraints)
		
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
		contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView(==scrollView)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        scrollConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
			
		titleLabel1Header.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel1Header]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
			
		titleLabel1.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel1]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
		
		titleLabel2Header.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel2Header]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
			
		titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel2]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
		
		titleLabel3Header.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel3Header]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
			
		titleLabel3.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel3]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
		
		contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[titleLabel1Header]-margin-[titleLabel1]-margin-[titleLabel2Header]-margin-[titleLabel2]-margin-[titleLabel3Header]-margin-[titleLabel3]-(>=margin)-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))

		view.addConstraints(mainConstraints)
        contentView.addConstraints(contentConstraints)
        scrollView.addConstraints(scrollConstraints)
	}
}

extension ExcelDetailViewController: DataResponse {

    func success() {
        
        title = ""
        
 		titleLabel1.text = String(int: item?.column1)
		
		titleLabel2.text = String(int: item?.column2)
		
		titleLabel3.text = item?.column3
		
       
    }
    
    func failure(error: NSError?) {
        ErrorManager.show(error, rootController: self)
    }
}

