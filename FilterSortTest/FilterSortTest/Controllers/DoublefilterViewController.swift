//
//  DoublefilterViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class DoublefilterViewController: SimpleCollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    typealias Cell = MosaicCell
    
    var items: [MenuItem]!
    
    override init() {
        
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnalyticsManager.sharedInstance?.analytics?.logPage("Menu")
        title = NSLocalizedString("Menu", comment: "")
        
		collectionView.delegate = self
        collectionView.dataSource = self
		
        items = [
			MenuItem(text: "Buildup",
                action: NavigationAction<BuildupBViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Center)
            ),
			MenuItem(text: "Google Drive",
                action: NavigationAction<GoogleDriveMenuItem1ViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Center)
            ),
			MenuItem(text: "EO",
                action: NavigationAction<EOViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Center)
            ),
			MenuItem(text: "GS",
                action: NavigationAction<GSViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Center)
            ),
			MenuItem(text: "Local",
                action: NavigationAction<LocalMenuItem1ViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Center)
            ),
	
        ]
        
		numberOfColumns = 2
		
        collectionView?.registerClass(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
		
		updateViewConstraints()
    }
    
    func configure(cell: Cell, indexPath: NSIndexPath) {
        
        let item = items[indexPath.row]
        if let alignment = item.textStyle?.alignment {
            cell.titleLabel.textAlignment = alignment
        }
        cell.titleLabel.font = item.textStyle?.font
        cell.titleLabel.text = item.text
        cell.photoImageView.loadImage(item.image)
        
        cell.userInteractionEnabled = false
        if let action = item.action where action.canBeExecuted() {
            cell.userInteractionEnabled = true
        }
    }
    
    // MARK: <UICollectionViewDatasource>
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell

        configure(cell, indexPath: indexPath)
        
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    // MARK: - <UICollectionViewDelegate>
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        let item = items[indexPath.row]
        item.action?.execute()
    }
}
