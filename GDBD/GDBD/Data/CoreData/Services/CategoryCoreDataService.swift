//
//  CategoryCoreDataService.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//

import Foundation

class CategoryCoreDataService {
    var persistenceController: PersistenceController
    
    init() {
        self.persistenceController = PersistenceController.shared
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func createCategory(name: String, completion: @escaping(_ category: Category?, _ error: Error?) -> Void) {
        let context = persistenceController.context
        let category = CategoryCDModel(context: context)
        
        category.name = name
        
        do {
            try context.save()
            return completion(CategoryCDModelFactory.createCategory(fromCategoryCDModel: category), nil)
        } catch {
            return completion(nil, error)
        }
    }
}
