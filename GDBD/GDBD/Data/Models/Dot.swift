//
//  Dot.swift
//  GDBD
//
//  Created by Samuel Wong on 10/9/2022.
//

import SwiftUI

struct Dot: Identifiable {
    let id: String?

    var dateTimeCreated: Date
    var isGood: Bool
    var text: String?
    var category: Category?
    
    internal init(id: String? = nil, dateTimeCreated: Date, isGood: Bool, text: String? = nil, category: Category? = nil) {
        self.id = id
        self.dateTimeCreated = dateTimeCreated
        self.isGood = isGood
        self.text = text
        self.category = category
    }
}
