//
//  SwitchInputView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class SwitchInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var check: UISwitch!
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
        
        check = UISwitch()
        addSubview(check)
        
        separator = UIView()
        separator.backgroundColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.disabled)
        addSubview(separator)
    }
    
    func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        check.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "check": check,
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
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[label]-margin-[check]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[check]-bottom-[separator(borderSize)]|",
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