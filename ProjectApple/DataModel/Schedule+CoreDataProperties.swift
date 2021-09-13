//
//  Schedule+CoreDataProperties.swift
//  ProjectApple
//
//  Created by PAMA on 08/09/2021.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var date: Date?
    @NSManaged public var productRel: NSSet?

}

// MARK: Generated accessors for productRel
extension Schedule {

    @objc(addProductRelObject:)
    @NSManaged public func addToProductRel(_ value: Product)

    @objc(removeProductRelObject:)
    @NSManaged public func removeFromProductRel(_ value: Product)

    @objc(addProductRel:)
    @NSManaged public func addToProductRel(_ values: NSSet)

    @objc(removeProductRel:)
    @NSManaged public func removeFromProductRel(_ values: NSSet)

}

extension Schedule : Identifiable {

}
