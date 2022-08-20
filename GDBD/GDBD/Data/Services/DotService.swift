//
//  DotService.swift
//  GDBD
//
//  Created by Samuel Wong on 19/8/2022.
//

protocol DotService {
    func createDot(isGood: Bool, withText text: String?, completion: @escaping(_ dot: Dot?, _ error: Error?) -> Void)
}
