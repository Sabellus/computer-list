//
//  Company+CoreDataProperties.swift
//  computer-list
//
//  Created by Савелий Вепрев on 11.02.2020.
//  Copyright © 2020 Савелий Вепрев. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var item: Item?

}
