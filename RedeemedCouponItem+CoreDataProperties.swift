//
//  RedeemedCouponItem+CoreDataProperties.swift
//  
//
//  Created by Stefan Jivalino on 13/08/23.
//
//

import Foundation
import CoreData


extension RedeemedCouponItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RedeemedCouponItem> {
        return NSFetchRequest<RedeemedCouponItem>(entityName: "RedeemedCouponItem")
    }

    @NSManaged public var couponId: String?

}
