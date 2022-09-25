//
//  Dot.swift
//  GDBD
//
//  Created by Samuel Wong on 10/9/2022.
//

import SwiftUI

struct Dot: Identifiable {
    let id: UUID = UUID()

    var dateTimeCreated: Date
    var isGood: Bool
    var text: String?
    
    internal init(dateTimeCreated: Date, isGood: Bool, text: String? = nil) {
        self.dateTimeCreated = dateTimeCreated
        self.isGood = isGood
        self.text = text
    }
}
