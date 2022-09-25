//
//  DotCDModelFactory.swift
//  GDBD
//
//  Created by Samuel Wong on 10/9/2022.
//

import Foundation

class DotCDModelFactory {
    private init() {}
    
    static func createDot(fromDotCDModel dotCDModel: DotCDModel) -> Dot {
        return Dot(id: dotCDModel.idString, dateTimeCreated: dotCDModel.dateTimeCreated!, isGood: dotCDModel.isGood, text: dotCDModel.text, category: dotCDModel.category != nil ? CategoryCDModelFactory.createCategory(fromCategoryCDModel: dotCDModel.category!) : nil)
    }
    
    static func createDots(fromDotCDModelArray dotCDModelArray: [DotCDModel]) -> [Dot] {
        return dotCDModelArray.map({ Dot(id: $0.idString, dateTimeCreated: $0.dateTimeCreated!, isGood: $0.isGood, text: $0.text, category: $0.category != nil ? CategoryCDModelFactory.createCategory(fromCategoryCDModel: $0.category!) : nil) })
    }
}
