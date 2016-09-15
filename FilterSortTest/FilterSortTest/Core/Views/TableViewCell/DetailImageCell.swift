//
//  DetailImageCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 17/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DetailImageCell: UITableViewCell {
    
    static let identifier = "DetailImageCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    var photoImageView: UIImageView!
    
    private var topView: UIView!
    private var bottomView: UIView!
    
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
        
        // Fix to center all labels vertically
        // TODO: Researching other options more efficient
        topView = UIView()
        contentView.addSubview(topView)
        bottomView = UIView()
        contentView.addSubview(bottomView)
        
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
        detailLabel.numberOfLines = 2
        detailLabel.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
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
        topView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        contentView.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "titleLabel": titleLabel,
            "detailLabel": detailLabel,
            "photoImageView": photoImageView,
            "topView": topView,
            "bottomView": bottomView
        ]
        
        let metrics = [
            "margin": Dimens.Margins.large,
            "imageSize": Dimens.Sizes.large
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[photoImageView(imageSize)]-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[photoImageView(imageSize@999)]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[topView(==bottomView)][titleLabel][detailLabel][bottomView(==topView)]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.append(NSLayoutConstraint(item: detailLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: titleLabel,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: detailLabel,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: titleLabel,
            attribute: .Width,
            multiplier: 1.0,
            constant: 0))
        
        contentView.addConstraints(mainConstraints)
    }
}