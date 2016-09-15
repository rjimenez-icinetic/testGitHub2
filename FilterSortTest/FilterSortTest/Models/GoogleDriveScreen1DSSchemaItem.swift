//
//  GoogleDriveScreen1DSSchemaItem.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

enum GoogleDriveScreen1DSSchemaItemMapping {
	static let id = "id"
	static let title = "title"
	static let createdBy = "createdBy"
	static let modifiedDate = "modifiedDate"
	static let downloadUrl = "downloadUrl"
}

public class GoogleDriveScreen1DSSchemaItem : Item {
	
	var id : String?
	var title : String!
	var createdBy : String!
	var modifiedDate : NSDate!
	var downloadUrl : String!
	
	// MAR: - <Item>

	public var identifier: AnyObject? {
		guard let identifier = id else {
			return ""
		}
		return identifier
	}
	
	required public init?(dictionary: NSDictionary?) {
    
        retrieve(dictionary)
    }
	
	public func retrieve(dictionary: NSDictionary?) {
     
        guard let dic = dictionary else {
            return
        }
        
 		id = dic[GoogleDriveScreen1DSSchemaItemMapping.id] as? String
		
		title = dic[GoogleDriveScreen1DSSchemaItemMapping.title] as? String
		
		createdBy = dic[GoogleDriveScreen1DSSchemaItemMapping.createdBy] as? String
		
		modifiedDate = NSDate.date(dic[GoogleDriveScreen1DSSchemaItemMapping.modifiedDate] as? String)
		
		downloadUrl = dic[GoogleDriveScreen1DSSchemaItemMapping.downloadUrl] as? String
		
	   
    }
}
	
