//
//  CombineAPIApp.swift
//  CombineAPI
//
//  Created by Ahmed Hamza on 3/3/25.
//

import SwiftUI

@main
struct CombineAPIApp: App {
    @StateObject var digimonVM = DigimonViewModel(apiManager: APIServiceManager(), coreDataManager: CoreDataManager())
    let persistanceController = PersistanceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(digimonVM)
                .environment(\.managedObjectContext, persistanceController.container.viewContext)

        }
    }
}
