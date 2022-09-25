//
//  CategoryCDModelFactory.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//

import Foundation

class CategoryCDModelFactory {
    private init() {}
    
    static func createCategory(fromCategoryCDModel categoryCDModel: CategoryCDModel) -> Category {
        return Category(id: categoryCDModel.idString, name: categoryCDModel.name!)
    }
    
    static func createCategories(fromCategoryCDModelArray categoryCDModelArray: [CategoryCDModel]) -> [Category] {
        return categoryCDModelArray.map({ Category(id: $0.idString, name: $0.name!) })
    }
}
