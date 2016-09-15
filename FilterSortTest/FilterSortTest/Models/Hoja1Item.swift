//
//  Hoja1Item.swift
//  FilterSortTest
//
//  This App has been generated using IBM Mobile App Builder
//

import Foundation

enum Hoja1ItemMapping {
	static let id = "id"
	static let name = "name"
	static let location = "location"
	static let sales = "sales"
	static let lastReview = "lastReview"
	static let review = "review"
	static let reviewDate = "reviewDate"
	static let performance = "performance"
	static let picture = "picture"
}

public class Hoja1Item : Item {
	
	var id : String?
	var name : String?
	var location : String?
	var sales : Double?
	var lastReview : String?
	var review : String?
	var reviewDate : NSDate?
	var performance : Double?
	var picture : String?
	
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
        
 		id = dic[Hoja1ItemMapping.id] as? String
		
		name = dic[Hoja1ItemMapping.name] as? String
		
		location = dic[Hoja1ItemMapping.location] as? String
		
		sales = dic[Hoja1ItemMapping.sales] as? Double
		
		lastReview = dic[Hoja1ItemMapping.lastReview] as? String
		
		review = dic[Hoja1ItemMapping.review] as? String
		
		reviewDate = NSDate.date(dic[Hoja1ItemMapping.reviewDate] as? String)
		
		performance = dic[Hoja1ItemMapping.performance] as? Double
		
		picture = dic[Hoja1ItemMapping.picture] as? String
		
	   
    }
}
	
