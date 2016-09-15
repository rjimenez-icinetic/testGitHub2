//
//  LocationField.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 27/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class RangeInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var startField: UITextField!
    var endField: UITextField!
    var errorLabel: UILabel!
    var separator: UIView!
    
    var contentInsets = UIEdgeInsetsMake(Dimens.Margins.medium, Dimens.Margins.medium, Dimens.Margins.medium, Dimens.Margins.medium)
    
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
        label.numberOfLines = 0
        label.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
        label.textColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.label)
        addSubview(label)
        
        startField = UITextField()
        startField.clearButtonMode = .WhileEditing
        startField.autocorrectionType = .No
        startField.borderStyle = .None
        startField.font = Style.sharedInstance.font
        startField.textColor = Style.sharedInstance.foregroundColor
        addSubview(startField)
        
        endField = UITextField()
        endField.clearButtonMode = .WhileEditing
        endField.autocorrectionType = .No
        endField.borderStyle = .None
        endField.font = Style.sharedInstance.font
        endField.textColor = Style.sharedInstance.foregroundColor
        addSubview(endField)
        
        errorLabel = UILabel()
        errorLabel.numberOfLines = 0
        errorLabel.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
        errorLabel.textColor = UIColor(rgb: Colors.error)
        addSubview(errorLabel)
        
        separator = UIView()
        separator.backgroundColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.disabled)
        addSubview(separator)
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(fieldTapAction))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
    }
    
    func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        startField.translatesAutoresizingMaskIntoConstraints = false
        endField.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "startField": startField,
            "endField": endField,
            "errorLabel": errorLabel,
            "separator": separator
        ]
        
        let metrics = [
            "top": contentInsets.top,
            "right": contentInsets.right,
            "bottom": contentInsets.bottom,
            "left": contentInsets.left,
            "margin": Dimens.Margins.medium,
            "marginSmall": Dimens.Margins.small,
            "fieldSize": Dimens.Sizes.small,
            "borderSize": Dimens.Sizes.border
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[label]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[startField]-margin-[endField(==startField)]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[errorLabel]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label]-marginSmall-[startField(>=fieldSize)][errorLabel]-bottom-[separator(borderSize)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.append(NSLayoutConstraint(item: endField,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: startField,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0))

        mainConstraints.append(NSLayoutConstraint(item: endField,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: startField,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        addConstraints(mainConstraints)
    }
    
    func fieldTapAction() {
        
        startField.becomeFirstResponder()
    }
}