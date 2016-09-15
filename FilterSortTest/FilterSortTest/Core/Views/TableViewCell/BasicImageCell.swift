//
//  BasicImageTableViewCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 16/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class BasicImageCell: UITableViewCell {
    
    static let identifier = "BasicImageCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    var photoImageView: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
        titleLabel.font = Style.sharedInstance.font
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
            "margin": Dimens.Margins.large,
            "imageSize": Dimens.Sizes.medium
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[photoImageView(imageSize)]-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        // Add priority 999 to fix warnings
        // http://stackoverflow.com/questions/28410309/strange-uiview-encapsulated-layout-height-error
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[photoImageView(imageSize@999)]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.append(NSLayoutConstraint(item: titleLabel,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: photoImageView,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        contentView.addConstraints(mainConstraints)
    }    
}
