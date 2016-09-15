//
//  Hoja1Schema1Item.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

enum Hoja1Schema1ItemMapping {
	static let id = "id"
	static let column1 = "column1"
	static let column2 = "column2"
	static let column3 = "column3"
}

public class Hoja1Schema1Item : Item {
	
	var id : String?
	var column1 : Int?
	var column2 : Int?
	var column3 : String?
	
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
        
 		id = dic[Hoja1Schema1ItemMapping.id] as? String
		
		column1 = dic[Hoja1Schema1ItemMapping.column1] as? Int
		
		column2 = dic[Hoja1Schema1ItemMapping.column2] as? Int
		
		column3 = dic[Hoja1Schema1ItemMapping.column3] as? String
		
	   
    }
}
	
