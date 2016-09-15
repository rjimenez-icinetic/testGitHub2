//
//  OptionsInputView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 30/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class OptionsInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var optionsLabel: UILabel!
    var iconImageView: UIImageView!
    var indicatorView: UIActivityIndicatorView!
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
        
        optionsLabel = UILabel()
        optionsLabel.numberOfLines = 0
        optionsLabel.font = Style.sharedInstance.font
        optionsLabel.textColor = Style.sharedInstance.foregroundColor
        addSubview(optionsLabel)
        
        iconImageView = UIImageView(image: UIImage(named: Images.arrow)?.imageWithRenderingMode(.AlwaysTemplate))
        iconImageView.tintColor = Style.sharedInstance.foregroundColor
        iconImageView.clipsToBounds = true
        addSubview(iconImageView)
        
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .White)
        indicatorView.hidesWhenStopped = true
        addSubview(indicatorView)
        
        errorLabel = UILabel()
        errorLabel.numberOfLines = 0
        errorLabel.font = Style.sharedInstance.font.fontWithSize(Fonts.Sizes.small)
        errorLabel.textColor = UIColor(rgb: Colors.error)
        addSubview(errorLabel)
        
        separator = UIView()
        separator.backgroundColor = Style.sharedInstance.foregroundColor.colorWithAlphaComponent(Colors.Alphas.disabled)
        addSubview(separator)
    }
    
    func setupConstraints() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        optionsLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "optionsLabel": optionsLabel,
            "iconImageView": iconImageView,
            "indicatorView": indicatorView,
            "errorLabel": errorLabel,
            "separator": separator
        ]
        
        let metrics = [
            "top": contentInsets.top,
            "right": contentInsets.right,
            "bottom": contentInsets.bottom,
            "left": contentInsets.left,
            "margin": Dimens.Margins.medium,
            "borderSize": Dimens.Sizes.border,
            "imageSize": Dimens.Sizes.medium
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[label]-margin-[iconImageView(imageSize)]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=top)-[iconImageView(imageSize)]-(>=bottom)-[separator(borderSize)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label][optionsLabel][errorLabel]-bottom-[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        errorLabel?.setContentHuggingPriority(UILayoutPriorityRequired,
                                              forAxis: .Vertical)
        
        mainConstraints.append(NSLayoutConstraint(item: optionsLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: label,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: optionsLabel,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: label,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: errorLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: label,
            attribute: .Left,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: errorLabel,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: label,
            attribute: .Right,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: iconImageView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: indicatorView,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: iconImageView,
            attribute: .CenterX,
            multiplier: 1.0,
            constant: 0))
        
        mainConstraints.append(NSLayoutConstraint(item: indicatorView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: iconImageView,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        addConstraints(mainConstraints)
    }
    
    func loading(isLoading: Bool) {
        iconImageView.hidden = isLoading
        if isLoading {
            indicatorView.startAnimating()
        } else {
            indicatorView.stopAnimating()
        }
        
    }
}
