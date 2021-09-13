//
//  Product+CoreDataProperties.swift
//  ProjectApple
//
//  Created by PAMA on 08/09/2021.
//
//

import Foundation
import CoreData


extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var calories: Int64
    @NSManaged public var carbohydrates: Int64
    @NSManaged public var fats: Int64
    @NSManaged public var name: String?
    @NSManaged public var proteins: Int64
    @NSManaged public var scheduleRel: NSSet?

}

// MARK: Generated accessors for scheduleRel
extension Product {

    @objc(addScheduleRelObject:)
    @NSManaged public func addToScheduleRel(_ value: Schedule)

    @objc(removeScheduleRelObject:)
    @NSManaged public func removeFromScheduleRel(_ value: Schedule)

    @objc(addScheduleRel:)
    @NSManaged public func addToScheduleRel(_ values: NSSet)

    @objc(removeScheduleRel:)
    @NSManaged public func removeFromScheduleRel(_ values: NSSet)

}

extension Product : Identifiable {

}
