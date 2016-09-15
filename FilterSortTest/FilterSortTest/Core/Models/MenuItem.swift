//
//  MenuItem.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 18/6/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import Foundation

struct MenuItem {

    var image: String?
    var text: String?
    var textStyle: TextStyle?
    var action: Action?
    
    init(image: String? = nil, text: String? = nil, action: Action? = nil, textStyle:TextStyle? = nil) {

        var style = textStyle
        if style == nil {
            style = TextStyle()
            style!.font = style!.font.fontWithSize(Fonts.Sizes.small)
        }
        self.image = image
        self.text = text
        self.textStyle = style
        self.action = action
    }
}