//
//  PreviewPersistanceDemoData.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//

import Foundation

class PreviewPersistanceDemoDataCreator {
    var persistanceController: PersistenceController
    
    var dots: [Dot] = []
    var categories: [Category] = []
    
    init(persistanceController: PersistenceController) {
        self.persistanceController = persistanceController
    }
    
    func createRandomDemoCategoryData() {
        let categoryService = CategoryCoreDataService(persistenceController: self.persistanceController)
        for i in 0 ..< 3 {
            categoryService.createCategory(name: "Category \(i)") { category, error in
                guard let category = category else { return }
                self.categories.append(category)
            }
        }
    }
    
    func createRandomDemoDotData() {
        let dotService = DotCoreDataService(persistenceController: self.persistanceController)
        for i in 0 ..< 30 {
            for j in 0 ..< 10 {
                if Int.random(in: 0..<2)%2 == 0 {
                    dotService.createDot(isGood: Int.random(in: 0..<2)%2 == 0, withText: "Dot number \(j)", atDate: Date().addingDays(numDays: -i), category: self.categories[Int.random(in: 0..<self.categories.count)]) { dot, error in
                        guard let dot = dot else { return }
                        self.dots.append(dot)
                    }
                }
            }
        }
    }
}
