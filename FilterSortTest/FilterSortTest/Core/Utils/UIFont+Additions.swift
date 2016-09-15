//
//  FontHelper.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 29/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

extension UIFont {

    convenience init(familyName: String, size: CGFloat, bold: Bool, italic: Bool) {
        
        let descriptor = UIFontDescriptor(fontAttributes: [
            UIFontDescriptorFamilyAttribute: familyName,
            UIFontDescriptorNameAttribute: (bold && italic ? "Bold Italic" : (bold ? "Bold" : (italic ? "Italic" : "Regular")))
            ])
        
        self.init(descriptor: descriptor, size: size)
    }
    
    convenience init(familyName: String, size: CGFloat) {
    
        self.init(familyName: familyName, size: size, bold: false, italic: false)
    }
}