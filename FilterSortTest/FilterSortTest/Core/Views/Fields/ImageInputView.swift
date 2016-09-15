//
//  ImageInputView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class ImageInputView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var label: UILabel!
    var imageView: UIImageView!
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
        
        imageView = UIImageView(image: UIImage(named: Images.noImage))
        imageView.backgroundColor = Style.sharedInstance.foregroundColor
        imageView.contentMode = .ScaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderColor = Style.sharedInstance.foregroundColor.CGColor
        imageView.layer.borderWidth = Dimens.Sizes.border
        imageView.layer.cornerRadius = Dimens.Sizes.large / 2
        addSubview(imageView)
        
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        separator.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views = [
            "label": label,
            "imageView": imageView,
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
            "imageSize": Dimens.Sizes.large
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[label]-margin-[imageView(imageSize)]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-(>=top)-[imageView(imageSize)]-(>=bottom)-[separator(borderSize)]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[label][errorLabel]-bottom-[separator]|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        errorLabel?.setContentHuggingPriority(UILayoutPriorityRequired,
                                                   forAxis: .Vertical)
        
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
        
        mainConstraints.append(NSLayoutConstraint(item: imageView,
            attribute: .CenterY,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterY,
            multiplier: 1.0,
            constant: 0))
        
        addConstraints(mainConstraints)
    }
}
