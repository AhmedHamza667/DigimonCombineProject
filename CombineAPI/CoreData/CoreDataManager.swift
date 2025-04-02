//
//  CoreDataManager.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/10/25.
//

import Foundation
import CoreData

protocol CoreDataManagerActions{
    func saveDataIntoDatabase(digimonList: [Digimon]) async throws
    func getDataFromDatabase()async throws -> [Digimon]
}

class CoreDataManager: CoreDataManagerActions {
    let viewContext = PersistanceController.shared.container.viewContext // viewContext to interect with Core Data entities
    
    func saveDataIntoDatabase(digimonList: [Digimon]) async throws {
        digimonList.forEach { digimon in
            let digimonEntity = DigimonEntity(context: viewContext) // Creates a DigimonEntity
            digimonEntity.name = digimon.name
            digimonEntity.level = digimon.level
            digimonEntity.img = digimon.img
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
            throw error
        }
    }
    
    func getDataFromDatabase() async throws -> [Digimon] {
        let fetchRequest: NSFetchRequest<DigimonEntity> = DigimonEntity.fetchRequest() // creates a fetch request
        let results = try viewContext.fetch(fetchRequest) // executes the request
            
        return results.map { entity in
            Digimon(name: entity.name ?? "",
                    level: entity.level ?? "",
                    img: entity.img ?? "")
        }
    }
    
}
