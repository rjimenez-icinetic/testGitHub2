//
//  UIImageView+MAB.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 9/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {

    func fixHeight(bounds: CGRect) {
    
        guard let img = image else {
            return
        }
        
        if img.size.width > CGRectGetWidth(bounds) {
        
            for constraint in constraints {
                
                if constraint.isKindOfClass(NSLayoutConstraint) {
                    
                    removeConstraint(constraint)
                }
            }
            
            let ratio = img.size.width / img.size.height
            
            let newSize = CGSizeMake(CGRectGetWidth(bounds), CGRectGetWidth(bounds) / ratio)
            
            let heightConstraint = NSLayoutConstraint(item: self,
                                                      attribute: .Height,
                                                      relatedBy: .Equal,
                                                      toItem: nil,
                                                      attribute: .NotAnAttribute,
                                                      multiplier: 1,
                                                      constant: newSize.height)
            addConstraint(heightConstraint)
        }
    }
    
    func loadImage(resource: String?, successfully: ((Bool) -> Void)) {
        
        guard let resource = resource else {
            image = Style.sharedInstance.placeHolderImage
            successfully(true)
            return
        }
        
        sd_setImageWithURL(NSURL(string: resource), placeholderImage: Style.sharedInstance.placeHolderImage,
                           completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) in
                            
                            successfully(image != nil && error == nil)
        })
    }
    
    func loadImage(resource: String?, containerView: UIView? = nil) {
    
        func assignImage(img: UIImage? = nil) {
        
            if let img = img {
                image = img
            } else {
                image = Style.sharedInstance.placeHolderImage
            }
            if let view = containerView {
                fixHeight(view.bounds)
            }
        }
        
        guard let resource = resource else {
            assignImage()
            return
        }
        
        if resource.isUrl() {
        
            if let view = containerView {
            
                sd_setImageWithURL(NSURL(string: resource), placeholderImage: Style.sharedInstance.placeHolderImage,
                                   completed: { (image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) in
                                    
                                    self.fixHeight(view.bounds)
                })
            
            } else {
            
                sd_setImageWithURL(NSURL(string: resource), placeholderImage: Style.sharedInstance.placeHolderImage)
            }
            
        } else {
            
            assignImage(UIImage(named: resource))
        }
    }
}