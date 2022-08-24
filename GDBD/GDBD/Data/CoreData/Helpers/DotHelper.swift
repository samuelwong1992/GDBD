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
    
    func createDot(isGood: Bool, withText text: String?, atDate: Date, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void) {
        let context = persistenceController.context
        let dot = Dot(context: context)
        
        dot.text = text
        dot.is_good = isGood
        dot.date_time_created = atDate
        
        do {
            try context.save()
            return completion(dot, nil)
        } catch {
            return completion(nil, error)
        }
    }
    
    func fetchDots(completion: @escaping(_ dots: [Dot], _ error: Error?) -> Void) {
        let dotsFetch = Dot.fetchRequest()
         
        do {
            let dots = try persistenceController.context.fetch(dotsFetch)
            return completion(dots, nil)
        } catch {
            return completion([], error)
        }

    }
}
