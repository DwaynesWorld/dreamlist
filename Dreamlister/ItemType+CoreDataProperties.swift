//
//  ItemType+CoreDataProperties.swift
//  Dreamlister
//
//  Created by Kyle Thompson on 11/19/16.
//  Copyright © 2016 KTinc. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
