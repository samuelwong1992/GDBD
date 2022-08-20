//
//  Dot+CoreDataProperties.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//
//

import Foundation
import CoreData


extension Dot {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dot> {
        return NSFetchRequest<Dot>(entityName: "Dot")
    }

    @NSManaged public var is_good: Bool
    @NSManaged public var text: String?
    @NSManaged public var date_time_created: Date?

}

extension Dot : Identifiable {

}
