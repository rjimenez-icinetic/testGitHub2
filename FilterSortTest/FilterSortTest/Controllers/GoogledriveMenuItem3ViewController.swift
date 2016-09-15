//
//  GoogledriveMenuItem3ViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class GoogledriveMenuItem3ViewController: TableViewController<GoogleDriveScreen1DSSchemaItem>, UITableViewDataSource, UITableViewDelegate {
    
    typealias Cell = DetailCell
    
    override init() {
        super.init()
		
		datasource = DatasourceManager.sharedInstance.GoogleDriveScreen1DS
	
		let sortOptions = DatasourceSortOptions(field: GoogleDriveScreen1DSSchemaItemMapping.title, ascending: false)
        datasourceOptions = DatasourceOptions(sortOptions: sortOptions)
		
		dataResponse = self
		
		behaviors.append(FilterBehavior<GoogledriveMenuItem3FilterViewController>(viewController: self))
		behaviors.append(SearchBehavior(viewController: self))
			
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnalyticsManager.sharedInstance?.analytics?.logPage("Googledrive")
        title = NSLocalizedString("Googledrive", comment: "")

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

extension GoogledriveMenuItem3ViewController: DataResponse {

    func success() {
        
        tableView.reloadData()
    }
    
    func failure(error: NSError?) {
        
        ErrorManager.show(error, rootController: self)
    }
}
