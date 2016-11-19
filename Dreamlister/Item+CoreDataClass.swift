//
//  Item+CoreDataClass.swift
//  Dreamlister
//
//  Created by Kyle Thompson on 11/19/16.
//  Copyright © 2016 KTinc. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }

}
