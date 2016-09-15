//
//  BuildupMenuItem2DetailViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class BuildupMenuItem2DetailViewController: DataViewController<BuildupCloudDSDSItem> {
    
    var didSetupConstraints = false
   
	var titleLabel1Header: UILabel!
	var titleLabel1: UILabel!
	var titleLabel2: UILabel!
	var titleLabel3: UILabel!
	var imageUrl4Header: UILabel!
	var imageUrl4: UIImageView!
	

	override init() {
        super.init()
        
        datasource = DatasourceManager.sharedInstance.BuildupCloudDSDS
        
        dataResponse = self

		behaviors.append(ShareBehavior(dataViewController: self))
		behaviors.append(UpdateBehavior<BuildupCloudDSDSFormViewController, BuildupCloudDSDSItem>(dataViewController: self))
		behaviors.append(DeleteBehavior(dataViewController: self))
	
    }
	
	override func viewDidLoad() {
        super.viewDidLoad()

		
		titleLabel1Header = createHeaderLabel("Text1")
		addSubview(titleLabel1Header)	
		
		titleLabel1 = createLabel()
		addSubview(titleLabel1)	
		
		titleLabel2 = createLabel()
		addSubview(titleLabel2)	
		
		titleLabel3 = createLabel()
		addSubview(titleLabel3)	
		
		imageUrl4Header = createHeaderLabel("Picture")
		addSubview(imageUrl4Header)	
		
		imageUrl4 = createImageView()
		addSubview(imageUrl4)	
		
	
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
			"titleLabel2": titleLabel2,
			"titleLabel3": titleLabel3,
			"imageUrl4Header": imageUrl4Header, 
			"imageUrl4": imageUrl4,
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
		
		titleLabel2.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel2]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
		
		titleLabel3.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel3]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
		
		imageUrl4Header.translatesAutoresizingMaskIntoConstraints = false
        contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[imageUrl4Header]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
			
		imageUrl4.translatesAutoresizingMaskIntoConstraints = false
		contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageUrl4]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        contentConstraints.append(NSLayoutConstraint(item: imageUrl4,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: contentView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
		contentConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[titleLabel1Header]-margin-[titleLabel1]-margin-[titleLabel2]-margin-[titleLabel3]-margin-[imageUrl4Header]-margin-[imageUrl4]-(>=margin)-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))

		view.addConstraints(mainConstraints)
        contentView.addConstraints(contentConstraints)
        scrollView.addConstraints(scrollConstraints)
	}
}

extension BuildupMenuItem2DetailViewController: DataResponse {

    func success() {
        
        title = ""
        
 		titleLabel1.text = item?.text1
		
		titleLabel2.text = item?.text2
		
		titleLabel3.text = item?.text3
		
		imageUrl4.loadImage(datasource.imagePath(item?.picture), containerView: view)
		
       
    }
    
    func failure(error: NSError?) {
        ErrorManager.show(error, rootController: self)
    }
}

