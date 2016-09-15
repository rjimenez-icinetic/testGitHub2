//
//  DoubleFilterLocalDSSchemaItem.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

enum DoubleFilterLocalDSSchemaItemMapping {
	static let id = "id"
	static let text1 = "text1"
	static let text2 = "text2"
	static let text3 = "text3"
}

public class DoubleFilterLocalDSSchemaItem : Item {
	
	var id : String?
	var text1 : String?
	var text2 : String?
	var text3 : String?
	
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
        
 		id = dic[DoubleFilterLocalDSSchemaItemMapping.id] as? String
		
		text1 = dic[DoubleFilterLocalDSSchemaItemMapping.text1] as? String
		
		text2 = dic[DoubleFilterLocalDSSchemaItemMapping.text2] as? String
		
		text3 = dic[DoubleFilterLocalDSSchemaItemMapping.text3] as? String
		
	   
    }
}
	
