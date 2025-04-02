//
//  PersistanceController.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/10/25.
//

import Foundation
import CoreData

struct PersistanceController{
    static let shared = PersistanceController() // singelton - shared instance of PersistanceController
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){ // if true optional in-memory for unit testing
        container = NSPersistentContainer(name: "DigimonStorage")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in // loads the store
            if let error = error as NSError? {
                fatalError ("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true // enables automatic merging
    }
}

