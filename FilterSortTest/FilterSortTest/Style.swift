//
//  Theme.swift
//  ReferenceApp
//
//  Created by Víctor Jordán Rosado on 19/5/16.
//  Copyright © 2016 Icinetic S.L. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

struct TextStyle {

    var color: UIColor!
    var font: UIFont!
    var alignment: NSTextAlignment!
    
    init(color: UIColor? = Style.sharedInstance.foregroundColor, font: UIFont? = Style.sharedInstance.font, alignment: NSTextAlignment? = .Left) {
    
        self.color = color
        self.font = font
        self.alignment = alignment
    }
}

struct Style {
    
    static let sharedInstance = Style()
    
    let font: UIFont
    
    let backgroundColor: UIColor
    let foregroundColor: UIColor
    let toolbarBackgroundColor: UIColor
    let toolbarTextColor: UIColor
    let selectedColor: UIColor
    
    let placeHolderImage: UIImage
    
    init() {
        
        // Fonts
        
        font = UIFont(familyName: Fonts.family, size: Fonts.Sizes.medium)
        
        // Colors
        
        backgroundColor = UIColor(rgb: Colors.background)
        foregroundColor = UIColor(rgb: Colors.foreground)
        toolbarBackgroundColor = UIColor(rgb: Colors.toolbarBackground)
        toolbarTextColor = UIColor(rgb: Colors.toolbarText)
        selectedColor = foregroundColor.colorWithAlphaComponent(Colors.Alphas.selected)
        
        // Images
        
        placeHolderImage = UIImage(named: Images.placeHolder)!
        
    }
    
    func apply() {
    
        tableViewStyle()
        collectionViewStyle()
        tableViewCellStyle()
        mapViewStyle()
        navigationBarStyle()
        toolbarStyle()
        barButtonItemStyle()
        activityIndicatorStyle()
        hudStyle()
        refreshControlStyle()
        switchStyle()
        segmentedControlStyle()
        searchBarStyle()
    }
    
    func tableViewStyle() {
    
        let appearance = UITableView.appearance()
        appearance.tintColor = foregroundColor
        appearance.backgroundView = nil
        appearance.backgroundColor = UIColor.clearColor()
        appearance.separatorColor = foregroundColor
        appearance.estimatedRowHeight = Dimens.rowHeight
        appearance.rowHeight = UITableViewAutomaticDimension
        appearance.separatorInset = UIEdgeInsetsZero
        appearance.tableFooterView = UIView()
    }
    
    func collectionViewStyle() {
    
        let appearance = UICollectionView.appearance()
        appearance.tintColor = foregroundColor
        appearance.backgroundColor = backgroundColor
    }
    
    func tableViewCellStyle() {
        
        let appearance = UITableViewCell.appearance()
        appearance.backgroundColor = UIColor.clearColor()
        appearance.preservesSuperviewLayoutMargins = false
        appearance.layoutMargins = UIEdgeInsetsZero
        appearance.separatorInset = UIEdgeInsetsZero
    }
    
    func mapViewStyle() {
    
        let appearance = MKMapView.appearance()
        appearance.tintColor = foregroundColor
    }
    
    func navigationBarStyle() {
    
        let appearance = UINavigationBar.appearance()
        appearance.tintColor = toolbarTextColor
        appearance.barTintColor = toolbarBackgroundColor
        appearance.titleTextAttributes = [
            
            NSForegroundColorAttributeName:toolbarTextColor,
            NSFontAttributeName: font
        ]
    }
    
    func toolbarStyle() {
        
        let appearance = UIToolbar.appearance()
        appearance.tintColor = toolbarTextColor
        appearance.barTintColor = toolbarBackgroundColor
    }
    
    func barButtonItemStyle() {
    
        let appearance = UIBarButtonItem.appearance()
        
        let normalAttr = [
            NSForegroundColorAttributeName:toolbarTextColor,
            NSFontAttributeName: font.fontWithSize(Fonts.Sizes.small)]
        
        appearance.setTitleTextAttributes(normalAttr, forState: .Normal)
        
        let disabledAttr = [
            NSForegroundColorAttributeName:toolbarTextColor.colorWithAlphaComponent(Colors.Alphas.disabled),
            NSFontAttributeName: font.fontWithSize(Fonts.Sizes.small)]
        
        appearance.setTitleTextAttributes(disabledAttr, forState: .Disabled)

    }
    
    func refreshControlStyle() {
    
        let appearance = UIRefreshControl.appearance()
        appearance.tintColor = foregroundColor
    }
    
    func activityIndicatorStyle() {
    
        let appearance = UIActivityIndicatorView.appearance()
        appearance.color = foregroundColor
    }
    
    func hudStyle() {
        
        SVProgressHUD.setDefaultStyle(.Custom)
        SVProgressHUD.setDefaultMaskType(.Custom)
        
        SVProgressHUD.setFont(font.fontWithSize(Fonts.Sizes.small))
        
        SVProgressHUD.setForegroundColor(foregroundColor)
        SVProgressHUD.setBackgroundColor(backgroundColor)
    }
    
    func switchStyle() {
    
        let appearance = UISwitch.appearance()
        appearance.tintColor = foregroundColor.colorWithAlphaComponent(Colors.Alphas.label)
        appearance.onTintColor = foregroundColor
    }
    
    func segmentedControlStyle() {
    
        let appearance = UISegmentedControl.appearance()
        appearance.tintColor = foregroundColor
    }
    
    func searchBarStyle() {
    
        let appearance = UISearchBar.appearance()
        appearance.tintColor = toolbarTextColor
        appearance.barTintColor = toolbarBackgroundColor.colorWithAlphaComponent(Colors.Alphas.overlay)
    }
    
    func font(size: CGFloat, bold: Bool? = false, italic: Bool? = false) -> UIFont {
    
        return UIFont(familyName: Fonts.family, size: size, bold: bold!, italic: italic!)
    }
}