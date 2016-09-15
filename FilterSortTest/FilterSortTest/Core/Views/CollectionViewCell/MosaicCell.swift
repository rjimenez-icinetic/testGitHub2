//
//  MosaicCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 23/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation
import UIKit

class MosaicCell: UICollectionViewCell {
    
    static let identifier = "MosaicCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    var photoImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateConstraints()
    }
    
    func setup() {
        
        backgroundView = nil
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = Style.sharedInstance.foregroundColor
        contentView.addSubview(titleLabel)
        
        photoImageView = UIImageView()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        contentView.addSubview(photoImageView)
        
        let selectedView = UIView(frame: CGRectZero)
        selectedView.backgroundColor = Style.sharedInstance.selectedColor
        selectedBackgroundView = selectedView
        
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        
        updateConstraints()
    }
    
    func setupConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "titleLabel": titleLabel,
            "photoImageView": photoImageView
        ]
        
        let metrics = [
            "zero": Dimens.Margins.none,
            "margin": Dimens.Margins.large,
            "titleHeight": Dimens.Sizes.medium
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-zero-[photoImageView]-zero-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        // Add priority 999 to fix warnings
        // http://stackoverflow.com/questions/28410309/strange-uiview-encapsulated-layout-height-error
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-zero-[photoImageView]-zero-[titleLabel(titleHeight)]-zero-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))

        contentView.addConstraints(mainConstraints)
    }
}