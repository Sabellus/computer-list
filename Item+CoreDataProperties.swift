//
//  Item+CoreDataProperties.swift
//  computer-list
//
//  Created by Савелий Вепрев on 11.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var descript: String?
    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var urlImage: String?
    @NSManaged public var updatedAt: Date?
    @NSManaged public var company: Company?

}
