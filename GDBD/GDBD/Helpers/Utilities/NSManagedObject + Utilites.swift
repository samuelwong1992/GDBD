//
//  NSManagedObject + Utilites.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//

import CoreData

extension NSManagedObject {
    var idString: String {
        return self.objectID.uriRepresentation().absoluteString
    }
}
