//
//  CreateDotViewStore.swift
//  GDBD
//
//  Created by Samuel Wong on 24/8/2022.
//

import Foundation

class CreateDotViewStore: ObservableObject {
    @Published var text: String = ""
    @Published var date: Date = Date()
    @Published var isGood: Bool
    
    @Published var error: Error? {
        didSet {
            showAlert = true
        }
    }
    @Published var showAlert: Bool = false
    
    var storageService: DotService
    
    internal init(isGood: Bool, storageService: DotService) {
        self.isGood = isGood
        self.storageService = storageService
    }
    
    func createDot(completion: @escaping((_ dot: Dot) -> Void)) {
        storageService.createDot(isGood: self.isGood, withText: self.text, atDate: self.date) { dot, error in
            guard error == nil else { self.error = error; return }
            guard let dot = dot else { self.error = NSError.standardNoDataError(); return }
            
            completion(dot)
        }
    }
    
    func dismissError() {
        self.error = nil
    }
}
