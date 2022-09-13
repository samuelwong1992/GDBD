//
//  Persistence.swift
//  GDBD
//
//  Created by Samuel Wong on 12/8/2022.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "GDBD")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    static var preview: PersistenceController = {
        let previewController = PersistenceController(inMemory: true)
        
        let dotService = DotCoreDataService(persistenceController: previewController)
        for i in 0 ..< 30 {
            for j in 0 ..< 10 {
                if Int.random(in: 0..<2)%2 == 0 {
                    dotService.createDot(isGood: Int.random(in: 0..<2)%2 == 0, withText: "Dot number \(j)", atDate: Date().addingDays(numDays: -i)) { dot, error in }
                }
            }
        }
        
        return previewController
    }()
    
    func createRandomDemoData() {
        let dotService = DotCoreDataService(persistenceController: self)
        for i in 0 ..< 30 {
            for j in 0 ..< 10 {
                if Int.random(in: 0..<2)%2 == 0 {
                    dotService.createDot(isGood: Int.random(in: 0..<2)%2 == 0, withText: "Dot number \(j)", atDate: Date().addingDays(numDays: -i)) { dot, error in }
                }
            }
        }
    }

}
