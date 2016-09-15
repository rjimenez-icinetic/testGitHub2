//
//  ContainerView.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 12/9/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

public class ContainerView: UIView {
    
    var didSetupConstraints = false
    var mainConstraints: [NSLayoutConstraint] = []
    
    var contentView: UIView!
    
    var contentInsets = UIEdgeInsetsMake(Dimens.Margins.medium, Dimens.Margins.medium, Dimens.Margins.medium, Dimens.Margins.medium)
    
    public init(contentView: UIView) {
        super.init(frame: CGRectZero)
        self.contentView = contentView
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
        if let contentView = contentView {
            addSubview(contentView)
        }
    }
    
    func setupConstraints() {
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        removeConstraints(mainConstraints)
        mainConstraints.removeAll()
        
        let views:[String: UIView] = [
            "contentView": contentView
        ]
        
        let metrics:[String: CGFloat] = [
            "top": contentInsets.top,
            "right": contentInsets.right,
            "bottom": contentInsets.bottom,
            "left": contentInsets.left
        ]
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("H:|-left-[contentView]-right-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        mainConstraints.appendContentsOf (NSLayoutConstraint.constraintsWithVisualFormat("V:|-top-[contentView]-bottom-|",
            options: .DirectionLeadingToTrailing,
            metrics: metrics,
            views: views))
        
        addConstraints(mainConstraints)
    }
}