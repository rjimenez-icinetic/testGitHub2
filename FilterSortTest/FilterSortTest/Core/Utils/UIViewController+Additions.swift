//
//  UIViewController+Additions.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 1/8/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit

extension UIViewController {

    func addBottomItem(item: UIBarButtonItem, animated: Bool) {
    
        var buttons: [UIBarButtonItem] = []
        if let toolbarItems = toolbarItems {
            buttons.appendContentsOf(toolbarItems)
        }
        let flexibleBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        buttons.append(flexibleBarButtonItem)
        buttons.append(item)
        buttons.append(flexibleBarButtonItem)
        setToolbarItems(buttons, animated: animated)
    }
}