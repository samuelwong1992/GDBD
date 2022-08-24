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
    
    internal init(succeeds: Bool) {
        self.succeeds = succeeds
    }
    
    func createDot(isGood: Bool, withText text: String?, atDate: Date, completion: @escaping (GDBD.Dot?, Error?) -> Void) {
        if succeeds {
            let dot = Dot()
            dot.is_good = isGood
            dot.text = text
            dot.date_time_created = atDate
            return completion(dot, nil)
        } else {
            return completion(nil, NSError.standardErrorWithString(errorString: "some error"))
        }
    }
}
