//
//  CollectionViewController.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 23/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class SimpleCollectionViewController: UIViewController  {
    
    let kMargin: CGFloat = Dimens.Margins.medium
    
    var numberOfColumns = 3
    
    var collectionView: UICollectionView!
    
    var flowLayout: UICollectionViewFlowLayout!
    
    var didSetupContraints = false
    
    lazy var mainConstraints: [NSLayoutConstraint] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    deinit {
        if collectionView.superview != nil {
            collectionView.removeFromSuperview()
        }
        collectionView = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Style.sharedInstance.backgroundColor
        
        if flowLayout == nil {
            flowLayout = UICollectionViewFlowLayout()
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .Vertical
        }
        
        if collectionView == nil  {
            collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        }
        
        collectionView?.alwaysBounceVertical = true
        view.addSubview(collectionView)
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
    
    func setupConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views:[String: AnyObject] = [
            "collectionView" : collectionView
        ]
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: views))
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:|[collectionView]|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: views))
        
        view.addConstraints(mainConstraints)
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        
        collectionView.performBatchUpdates(nil, completion: nil)
    }
    
    // MARK: - <UICollectionViewDelegateFlowLayout>
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let minimumInteritemSpacing = self.collectionView(collectionView, layout: collectionViewLayout, minimumInteritemSpacingForSectionAtIndex: indexPath.section)
        let width = collectionView.frame.size.width - kMargin * 2
        let cellSize = CGFloat(floorf(Float(width / CGFloat(numberOfColumns)))) - CGFloat(numberOfColumns - 1) * minimumInteritemSpacing
        return CGSizeMake(cellSize, cellSize)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return kMargin
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        
        return kMargin / CGFloat(numberOfColumns)
    }
}