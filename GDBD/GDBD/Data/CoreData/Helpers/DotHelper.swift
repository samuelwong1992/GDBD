//
//  DotHelper.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation

class DotCoreDataService: DotService {
    func createDot(isGood: Bool, withText text: String?, atDate: Date, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void) {
        let context = PersistenceController.shared.context
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
}
