//
//  DotHelper.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation
import CoreData

class DotCoreDataService: DotService {
    var persistenceController: PersistenceController
    
    init() {
        self.persistenceController = PersistenceController.shared
    }
    
    init(persistenceController: PersistenceController) {
        self.persistenceController = persistenceController
    }
    
    func createDot(isGood: Bool, withText text: String?, atDate: Date, category: Category?, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void) {
        let context = persistenceController.context
        let dot = DotCDModel(context: context)
        
        dot.text = text
        dot.isGood = isGood
        dot.dateTimeCreated = atDate
        
        do {
            if let category = category, let id = category.id {
                if let url = URL(string: id), let managedObjectID = context.persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) {
                    let categoryInCoreData = try context.existingObject(with: managedObjectID) as! CategoryCDModel
                    dot.category = categoryInCoreData
                    print("gets here")
                    print(dot.category?.name)
                }
            }
            try context.save()
            return completion(DotCDModelFactory.createDot(fromDotCDModel: dot), nil)
        } catch {
            return completion(nil, error)
        }
    }
    
    func fetchDotsBetweenDate(startDate: Date, endDate: Date, completion: @escaping ([Dot], Error?) -> Void) {
        let dotsFetch = DotCDModel.fetchRequest()
        dotsFetch.predicate = NSPredicate(format: "dateTimeCreated >= %@ AND dateTimeCreated < %@", startDate as NSDate, endDate as NSDate)
         
        do {
            let dots = try persistenceController.context.fetch(dotsFetch)
            return completion(DotCDModelFactory.createDots(fromDotCDModelArray: dots), nil)
        } catch {
            return completion([], error)
        }
    }
    
    func fetchEarliestDot(completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void) {
        let dotsFetch = DotCDModel.fetchRequest()
        dotsFetch.sortDescriptors = [NSSortDescriptor(key: "dateTimeCreated", ascending: true)]
        dotsFetch.fetchLimit = 1
         
        do {
            let dots = try persistenceController.context.fetch(dotsFetch)
            if let dot = dots.first {
                return completion(DotCDModelFactory.createDot(fromDotCDModel: dot), nil)
            } else {
                return completion(nil, nil)
            }
        } catch {
            return completion(nil, error)
        }
    }
}
