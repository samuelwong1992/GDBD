//
//  DotService.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

import Foundation

protocol DotService {
    func createDot(isGood: Bool, withText text: String?, atDate: Date, category: Category?, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void)
    func fetchDotsBetweenDate(startDate: Date, endDate: Date, completion: @escaping(_ dots: [Dot], _ error: Error?) -> Void)
    func fetchEarliestDot(completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void)
}
