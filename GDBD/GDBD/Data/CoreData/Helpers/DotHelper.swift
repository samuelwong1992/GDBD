//
//  DotHelper.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation

class DotCoreDataService: DotService {
    func createDot(isGood: Bool, withText text: String?, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void) {
        let context = PersistenceController.shared.context
        let dot = Dot(context: context)
        
        do {
            try context.save()
            return completion(dot, nil)
        } catch {
            return completion(nil, error)
        }
    }
}
