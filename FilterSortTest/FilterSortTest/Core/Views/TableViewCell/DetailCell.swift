//
//  DetailTableViewCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 16/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    static let identifier = "DetailCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    var detailLabel: UILabel!
    
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
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "titleLabel": titleLabel,
            "detailLabel": detailLabel
        ]
        
        let metrics = [
            "margin": Dimens.Margins.large
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[detailLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[titleLabel][detailLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        contentView.addConstraints(mainConstraints)
    }
}
