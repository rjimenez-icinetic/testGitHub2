//
//  InfoImageCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 17/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class InfoImageCell: UITableViewCell {
    
    static let identifier = "InfoImageCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
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
        
        photoImageView = UIImageView()
        photoImageView.clipsToBounds = true
        photoImageView.contentMode = .ScaleAspectFill
        contentView.addSubview(photoImageView)
        
        titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = Style.sharedInstance.font
        titleLabel.textColor = Style.sharedInstance.foregroundColor
        contentView.addSubview(titleLabel)
        
        detailLabel = UILabel()
        detailLabel.numberOfLines = 4
        detailLabel.font = Style.sharedInstance.font
        detailLabel.textColor = Style.sharedInstance.foregroundColor
        contentView.addSubview(detailLabel)
        
        let selectedView = UIView(frame: CGRectZero)
        selectedView.backgroundColor = Style.sharedInstance.selectedColor
        selectedBackgroundView = selectedView
        
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        
        updateConstraints()
    }
    
    func setupConstraints() {
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "titleLabel": titleLabel,
            "detailLabel": detailLabel,
            "photoImageView": photoImageView
        ]
        
        let metrics = [
            "margin": Dimens.Margins.large,
            "marginMedium": Dimens.Margins.medium,
            "imageSize": Dimens.Sizes.large
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[photoImageView(imageSize)]-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[detailLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[photoImageView(imageSize)]-marginMedium-[detailLabel]-margin-|",
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
