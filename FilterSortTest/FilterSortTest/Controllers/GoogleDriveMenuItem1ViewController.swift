//
//  GoogleDriveMenuItem1ViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class GoogleDriveMenuItem1ViewController: TableViewController<GoogleDriveScreen1DSSchemaItem>, UITableViewDataSource, UITableViewDelegate {
    
    typealias Cell = DetailCell
    
    override init() {
        super.init()
		
		datasource = DatasourceManager.sharedInstance.GoogleDriveScreen1DS
	
        datasourceOptions = DatasourceOptions()
        datasourceOptions.addDesignFilter(datasource?.datasourceFilter.create(GoogleDriveScreen1DSSchemaItemMapping.createdBy, string: "Marina"))
		
		dataResponse = self
		
		behaviors.append(FilterBehavior<GoogleDriveMenuItem1FilterViewController>(viewController: self))
			
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnalyticsManager.sharedInstance?.analytics?.logPage("Google Drive")
        title = NSLocalizedString("Google Drive", comment: "")

        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(Cell.self, forCellReuseIdentifier: Cell.identifier)

        updateViewConstraints()
		
        loadData()		
    }
    
	//MARK: - <UITableViewDataSource>
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
	
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier(Cell.identifier, forIndexPath: indexPath) as! Cell

		// No detail or actions
        cell.userInteractionEnabled = false
	
        
        
        // Binding 
        let item = items[indexPath.row]
		cell.titleLabel.text = item.title
		cell.detailLabel.text = item.createdBy
		
		// Styles
		
		cell.detailLabel.font = Style.sharedInstance.font(Fonts.Sizes.small, bold: false, italic: false)
		
		return cell
    }

	 //MARK: - <UITableViewDelegate>
	 
	func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        loadMoreData(indexPath.row)
		
		cell.preservesSuperviewLayoutMargins = false
        cell.layoutMargins = UIEdgeInsetsZero
        cell.separatorInset = UIEdgeInsetsZero
    }

}

//MARK: - <DataResponse>

extension GoogleDriveMenuItem1ViewController: DataResponse {

    func success() {
        
        tableView.reloadData()
    }
    
    func failure(error: NSError?) {
        
        ErrorManager.show(error, rootController: self)
    }
}
