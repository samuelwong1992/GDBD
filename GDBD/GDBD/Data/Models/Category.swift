//
//  Category.swift
//  GDBD
//
//  Created by Samuel Wong on 25/9/2022.
//

import Foundation

struct Category: Identifiable {
    let id: String?

    var name: String
    
    internal init(id: String? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
