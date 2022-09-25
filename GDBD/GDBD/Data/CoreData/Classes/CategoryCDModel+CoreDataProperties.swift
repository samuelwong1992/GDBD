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
    @NSManaged public var dots: DotCDModel?

}

extension CategoryCDModel : Identifiable {

}
