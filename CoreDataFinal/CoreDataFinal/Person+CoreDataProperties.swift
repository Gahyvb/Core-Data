//
//  Person+CoreDataProperties.swift
//  CoreDataFinal
//
//  Created by Geoffrey Husser on 12/1/17.
//  Copyright © 2017 Geoffrey Husser. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var number: Int16

}
