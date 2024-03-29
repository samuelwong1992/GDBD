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
            showAlert = error != nil
        }
    }
    @Published var showAlert: Bool = false
    
    var storageService: DotService
    
    internal init(isGood: Bool, storageService: DotService) {
        self.isGood = isGood
        self.storageService = storageService
    }
    
    func createDot(completion: @escaping((_ dot: Dot?) -> Void)) {
        storageService.createDot(isGood: self.isGood, withText: self.text, atDate: self.date, category: nil) { dot, error in
            guard error == nil else { self.error = error; completion(nil); return }
            guard let dot = dot else { self.error = NSError.standardNoDataError(); completion(nil);  return }
            
            completion(dot)
        }
    }
    
    func dismissError() {
        self.error = nil
    }
}
