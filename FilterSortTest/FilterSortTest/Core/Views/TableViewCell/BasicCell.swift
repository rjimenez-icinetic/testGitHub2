//
//  TitleTableViewCell.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 15/4/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {

    static let identifier = "BasicCellIdentifier"
    
    var didSetupConstraints = false
    
    var mainConstraints: [NSLayoutConstraint] = []
    
    var titleLabel: UILabel!
    
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
        
        let selectedView = UIView(frame: CGRectZero)
        selectedView.backgroundColor = Style.sharedInstance.selectedColor
        selectedBackgroundView = selectedView
        
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
        
        updateConstraints()
    }
    
    func setupConstraints() {
    
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "titleLabel": titleLabel
        ]
        
        let metrics = [
            "margin": Dimens.Margins.large
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-margin-[titleLabel]-margin-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        contentView.addConstraints(mainConstraints)
    }    
}
