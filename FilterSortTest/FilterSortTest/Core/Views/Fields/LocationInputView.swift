//
//  LocationInputView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 28/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class LocationInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var latField: UITextField!
    var lngField: UITextField!
    var errorLabel: UILabel!
    var separator: UIView!
    var locationButton: UIButton!
    
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
        
        latField = UITextField()
        latField.clearButtonMode = .WhileEditing
        latField.autocorrectionType = .No
        latField.borderStyle = .None
        latField.font = Style.sharedInstance.font
        latField.textColor = Style.sharedInstance.foregroundColor
        addSubview(latField)
        
        lngField = UITextField()
        lngField.clearButtonMode = .WhileEditing
        lngField.autocorrectionType = .No
        lngField.borderStyle = .None
        lngField.font = Style.sharedInstance.font
        lngField.textColor = Style.sharedInstance.foregroundColor
        addSubview(lngField)
        
        locationButton = UIButton(type: .Custom)
        locationButton.setImage(UIImage(named: Images.userLocation)?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        locationButton.tintColor = Style.sharedInstance.foregroundColor
        addSubview(locationButton)

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
        latField.translatesAutoresizingMaskIntoConstraints = false
        lngField.translatesAutoresizingMaskIntoConstraints = false
        locationButton.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "latField": latField,
            "lngField": lngField,
            "locationButton": locationButton,
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
            "borderSize": Dimens.Sizes.border,
            "buttonSize": Dimens.Sizes.medium
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[latField]-margin-[lngField(==latField)]-margin-[locationButton(buttonSize)]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf(NSLayoutConstraint.constraintsWithVisualFormat("V:[locationButton(buttonSize)]",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label]-marginSmall-[latField(>=fieldSize)][errorLabel]-bottom-[separator(borderSize)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.append(NSLayoutConstraint(item: label,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: latField,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: label,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: lngField,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: errorLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: latField,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: errorLabel,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: lngField,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: lngField,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: latField,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: lngField,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: latField,
            attribute: .Height,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: locationButton,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        addConstraints(mainConstraints)
    }
    
    func fieldTapAction() {
        
        latField.becomeFirstResponder()
    }
}