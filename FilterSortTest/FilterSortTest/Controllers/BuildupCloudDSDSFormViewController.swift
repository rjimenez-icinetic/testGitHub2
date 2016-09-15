//
//  BuildupCloudDSDSFormViewController.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//
import UIKit

class BuildupCloudDSDSFormViewController: FormViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

		AnalyticsManager.sharedInstance?.analytics?.logPage("")
		let item = self.item as? BuildupCloudDSDSItem
    
		let text1Field = StringField(name: BuildupCloudDSDSItemMapping.text1, label: "Text1", required: false, value: item?.text1)
        contentView.addSubview(text1Field)
		
		let text2Field = StringField(name: BuildupCloudDSDSItemMapping.text2, label: "Text2", required: false, value: item?.text2)
        contentView.addSubview(text2Field)
		
		let pictureField = ImageField(name: BuildupCloudDSDSItemMapping.picture, label: "Picture", required: false, viewController: self, value: crudService?.imagePath(item?.picture))
        contentView.addSubview(pictureField)
		
		let text3Field = StringField(name: BuildupCloudDSDSItemMapping.text3, label: "Text3", required: false, value: item?.text3)
        contentView.addSubview(text3Field)
		
       
        updateViewConstraints()
        
        retrieveFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
