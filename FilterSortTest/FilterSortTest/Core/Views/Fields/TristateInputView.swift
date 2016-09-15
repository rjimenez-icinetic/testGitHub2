//
//  TristateInputView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class TristateInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var segmentedControl: UISegmentedControl!
    var separator: UIView!
    
    var contentInsets = UIEdgeInsetsMake(Dimens.Margins.large, Dimens.Margins.medium, Dimens.Margins.large, Dimens.Margins.medium)
    
    public init() {
        super.init(frame: CGRectZero)
        setup()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override public func updateConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
            setupConstraints()
        }
        super.updateConstraints()
    }
    
    func setup() {
        
        backgroundColor = UIColor.clearColor()
        
        label = UILabel()
        label.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
        label.textColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.label)
        addSubview(label)
        
        segmentedControl = UISegmentedControl(items: ["✓", "-", "✗"])
        segmentedControl.setWidth(Dimens.Sizes.large, forSegmentAtIndex: 0)
        segmentedControl.setWidth(Dimens.Sizes.large, forSegmentAtIndex: 1)
        segmentedControl.setWidth(Dimens.Sizes.large, forSegmentAtIndex: 2)
        addSubview(segmentedControl)
        
        separator = UIView()
        separator.backgroundColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.disabled)
        addSubview(separator)
    }
    
    func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "segmentedControl": segmentedControl,
            "separator": separator
        ]
        
        let metrics = [
            "top": contentInsets.top,
            "right": contentInsets.right,
            "bottom": contentInsets.bottom,
            "left": contentInsets.left,
            "margin": Dimens.Margins.medium,
            "borderSize": Dimens.Sizes.border
        ]
        
        segmentedControl.setContentHuggingPriority(UILayoutPriorityRequired,
                                                   forAxis: .Horizontal)
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[label]-margin-[segmentedControl]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[segmentedControl]-bottom-[separator(borderSize)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.append(NSLayoutConstraint(item: label,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 1))
        
        addConstraints(mainConstraints)
    }
}