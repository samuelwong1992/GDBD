//
//  CategoryCDModel+CoreDataProperties.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//
//

import Foundation
import CoreData


extension CategoryCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryCDModel> {
        return NSFetchRequest<CategoryCDModel>(entityName: "CategoryCDModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var dots: NSSet?

}

// MARK: Generated accessors for dots
extension CategoryCDModel {

    @objc(addDotsObject:)
    @NSManaged public func addToDots(_ value: DotCDModel)

    @objc(removeDotsObject:)
    @NSManaged public func removeFromDots(_ value: DotCDModel)

    @objc(addDots:)
    @NSManaged public func addToDots(_ values: NSSet)

    @objc(removeDots:)
    @NSManaged public func removeFromDots(_ values: NSSet)

}

extension CategoryCDModel : Identifiable {

}
