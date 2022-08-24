//
//  DotMockService.swift
//  GDBDTests
//
//  Created by Samuel Wong on 24/8/2022.
//

import Foundation
@testable import GDBD

class DotMockService: DotService {
    var succeeds: Bool
    let persistanceController = PersistenceController(inMemory: true)
    
    internal init(succeeds: Bool) {
        self.succeeds = succeeds
    }
    
    func createDot(isGood: Bool, withText text: String?, atDate: Date, completion: @escaping (GDBD.Dot?, Error?) -> Void) {
        if succeeds {
            let dot = Dot(context: persistanceController.context)
            dot.is_good = isGood
            dot.text = text
            dot.date_time_created = atDate
            return completion(dot, nil)
        } else {
            return completion(nil, NSError.standardErrorWithString(errorString: "some error"))
        }
    }
    
    func fetchDots(completion: @escaping ([GDBD.Dot], Error?) -> Void) {
        let test_isGood = true
        let test_text = "some text"
        let test_date = Date()
        
        if succeeds {
            let dot = Dot(context: persistanceController.context)
            dot.is_good = test_isGood
            dot.text = test_text
            dot.date_time_created = test_date
            return completion([dot], nil)
        } else {
            return completion([], NSError.standardErrorWithString(errorString: "some error"))
        }
    }
}
