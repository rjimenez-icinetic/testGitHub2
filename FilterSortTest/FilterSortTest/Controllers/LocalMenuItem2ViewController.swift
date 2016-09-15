//
//  LocalMenuItem2ViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import UIKit

class LocalMenuItem2ViewController: TableViewController<LocalDSDSSchemaItem>, UITableViewDataSource, UITableViewDelegate {
    
    typealias Cell = DetailImageCell
    
    override init() {
        super.init()
		
		datasource = DatasourceManager.sharedInstance.LocalDSDS
		
		dataResponse = self
		
			
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AnalyticsManager.sharedInstance?.analytics?.logPage("Local")
        title = NSLocalizedString("Local", comment: "")

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
			
		 
        cell.photoImageView.loadImage(datasource.imagePath(item.picture))
		cell.titleLabel.text = item.text1
		cell.detailLabel.text = item.text2
		
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

extension LocalMenuItem2ViewController: DataResponse {

    func success() {
        
        tableView.reloadData()
    }
    
    func failure(error: NSError?) {
        
        ErrorManager.show(error, rootController: self)
    }
}
