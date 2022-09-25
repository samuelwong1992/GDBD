//
//  DotCDModel+CoreDataProperties.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//
//

import Foundation
import CoreData


extension DotCDModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DotCDModel> {
        return NSFetchRequest<DotCDModel>(entityName: "DotCDModel")
    }

    @NSManaged public var dateTimeCreated: Date?
    @NSManaged public var isGood: Bool
    @NSManaged public var text: String?
    @NSManaged public var category: CategoryCDModel?

}

extension DotCDModel : Identifiable {

}
