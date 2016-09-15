//
//  LocalDSDSSchemaItem.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

enum LocalDSDSSchemaItemMapping {
	static let id = "id"
	static let text1 = "text1"
	static let text2 = "text2"
	static let picture = "picture"
	static let text3 = "text3"
	static let order = "order"
	static let puntiation = "puntiation"
	static let createAt = "createAt"
	static let isActive = "isActive"
}

public class LocalDSDSSchemaItem : Item {
	
	var id : String?
	var text1 : String?
	var text2 : String?
	var picture : String?
	var text3 : String?
	var order : Int?
	var puntiation : Double?
	var createAt : NSDate?
	var isActive : Bool?
	
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
        
 		id = dic[LocalDSDSSchemaItemMapping.id] as? String
		
		text1 = dic[LocalDSDSSchemaItemMapping.text1] as? String
		
		text2 = dic[LocalDSDSSchemaItemMapping.text2] as? String
		
		picture = dic[LocalDSDSSchemaItemMapping.picture] as? String
		
		text3 = dic[LocalDSDSSchemaItemMapping.text3] as? String
		
		order = dic[LocalDSDSSchemaItemMapping.order] as? Int
		
		puntiation = dic[LocalDSDSSchemaItemMapping.puntiation] as? Double
		
		createAt = NSDate.date(dic[LocalDSDSSchemaItemMapping.createAt] as? String)
		
		isActive = dic[LocalDSDSSchemaItemMapping.isActive] as? Bool
		
	   
    }
}
	
