//
//  DotService.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation

protocol DotService {
    func createDot(isGood: Bool, withText text: String?, atDate: Date, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void)
}
