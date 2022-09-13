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
            let dot = Dot(
                dateTimeCreated: atDate,
                isGood: isGood,
                text: text)
            return completion(dot, nil)
        } else {
            return completion(nil, NSError.standardErrorWithString(errorString: "some error"))
        }
    }
    
    func fetchDotsBetweenDate(startDate: Date, endDate: Date, completion: @escaping ([GDBD.Dot], Error?) -> Void) {
        let test_isGood = true
        let test_text = "some text"
        let test_date = Date()
        
        if succeeds {
            let dot = Dot(
                dateTimeCreated: test_date,
                isGood: test_isGood,
                text: test_text
            )
            return completion([dot], nil)
        } else {
            return completion([], NSError.standardErrorWithString(errorString: "some error"))
        }
    }
    
    func fetchEarliestDot(completion: @escaping (GDBD.Dot?, Error?) -> Void) {
        let test_isGood = true
        let test_text = "some text"
        let test_date = Date()
        
        if succeeds {
            let dot = Dot(
                dateTimeCreated: test_date,
                isGood: test_isGood,
                text: test_text
            )
            return completion(dot, nil)
        } else {
            return completion(nil, NSError.standardErrorWithString(errorString: "some error"))
        }
    }
}
