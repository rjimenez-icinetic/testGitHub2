//
//  Screen0ViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class Screen0ViewController: UITableViewController {
    
    typealias Cell = BasicCell
    
    var items: [MenuItem]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Style.sharedInstance.backgroundColor

        AnalyticsManager.sharedInstance?.analytics?.logPage("2-Design Filters")
        
		
        items = [
			MenuItem(text: "BuildupList",
                action: NavigationAction<BuildupListViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Left)
            ),
			MenuItem(text: "LocalList",
                action: NavigationAction<LocalListViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Left)
            ),
			MenuItem(text: "EOList",
                action: NavigationAction<EOListViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Left)
            ),
			MenuItem(text: "GDList",
                action: NavigationAction<GDListViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Left)
            ),
			MenuItem(text: "GSList",
                action: NavigationAction<GSListViewController>(rootViewController: self),
				image: "DefaultMenuIcon.png",
				textStyle: TextStyle(alignment: .Left)
            ),
		
        ]
        
        tableView.registerClass(Cell.self, forCellReuseIdentifier: Cell.identifier)
    }
    
    func configure(cell: Cell, indexPath: NSIndexPath) {
    
        let item = items[indexPath.row]
        cell.titleLabel.textColor = item.textStyle?.color
        cell.titleLabel.font = item.textStyle?.font
        cell.titleLabel.text = item.text

        cell.userInteractionEnabled = false
        cell.accessoryView = nil
        cell.accessoryType = .None
        if let action = item.action where action.canBeExecuted() {
            
            cell.userInteractionEnabled = true

            // You can customize the accessory icon ...
            let icon = UIImage(named: Images.arrow)?.imageWithRenderingMode(.AlwaysTemplate)
            let accessoryImageView = UIImageView(image: icon)
            accessoryImageView.tintColor = Style.sharedInstance.foregroundColor
            cell.accessoryView = accessoryImageView
        }
    }
    
    //MARK: - <UITableViewDataSource>
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell
        
        configure(cell, indexPath: indexPath)
        
        return cell
    }
    
    //MARK: - <UITableViewDelegate>
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = items[indexPath.row]
        item.action?.execute()
    }
}
